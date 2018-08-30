import json
import os
import sys

import numpy as np
import pandas as pd
from tqdm import tqdm

from keras.models import Model  # Sequential
from keras.layers import Input, Dense, LSTM  # Dropout, Activation, Embedding
from keras.utils.vis_utils import plot_model

from nlpia.loaders import get_data


def load_embeddings(path):
    embeddings = []
    for movie_dir in os.listdir(path):
        if '.' in movie_dir:
            continue
        movie_path = os.path.join(path, movie_dir)
        for json_file in tqdm(os.listdir(movie_path)):
            json_path = os.path.join(path, movie_dir, json_file)
            with open(json_path) as fin:
                clip_js = json.load(fin)
            for emb in clip_js['embeddings']:
                embeddings.append([json_path, emb['frame_id'], np.array(emb['mbox_loc'])])
    return embeddings


def define_models(n_input, n_output, n_units):
    # define training encoder
    encoder_inputs = Input(shape=(None, n_input))
    encoder = LSTM(n_units, return_state=True)
    encoder_outputs, state_h, state_c = encoder(encoder_inputs)
    encoder_states = [state_h, state_c]
    # define training decoder
    decoder_inputs = Input(shape=(None, n_output))
    decoder_lstm = LSTM(n_units, return_sequences=True, return_state=True)
    decoder_outputs, _, _ = decoder_lstm(decoder_inputs, initial_state=encoder_states)
    decoder_dense = Dense(n_output, activation='softmax')
    decoder_outputs = decoder_dense(decoder_outputs)
    model = Model([encoder_inputs, decoder_inputs], decoder_outputs)
    # define inference encoder
    encoder_model = Model(encoder_inputs, encoder_states)
    # define inference decoder
    decoder_state_input_h = Input(shape=(n_units,))
    decoder_state_input_c = Input(shape=(n_units,))
    decoder_states_inputs = [decoder_state_input_h, decoder_state_input_c]
    decoder_outputs, state_h, state_c = decoder_lstm(decoder_inputs, initial_state=decoder_states_inputs)
    decoder_states = [state_h, state_c]
    decoder_outputs = decoder_dense(decoder_outputs)
    decoder_model = Model([decoder_inputs] + decoder_states_inputs, [decoder_outputs] + decoder_states)
    # return all models
    return model, encoder_model, decoder_model


def train_lstm():
    # configure
    num_encoder_tokens = 71
    num_decoder_tokens = 93
    latent_dim = 256
    # Define an input sequence and process it.
    encoder_inputs = Input(shape=(None, num_encoder_tokens))
    encoder = LSTM(latent_dim, return_state=True)
    encoder_outputs, state_h, state_c = encoder(encoder_inputs)
    # We discard `encoder_outputs` and only keep the states.
    encoder_states = [state_h, state_c]
    # Set up the decoder, using `encoder_states` as initial state.
    decoder_inputs = Input(shape=(None, num_decoder_tokens))
    # We set up our decoder to return full output sequences,
    # and to return internal states as well. We don't use the
    # return states in the training model, but we will use them in inference.
    decoder_lstm = LSTM(latent_dim, return_sequences=True, return_state=True)
    decoder_outputs, _, _ = decoder_lstm(decoder_inputs, initial_state=encoder_states)
    decoder_dense = Dense(num_decoder_tokens, activation='softmax')
    decoder_outputs = decoder_dense(decoder_outputs)
    # Define the model that will turn
    # `encoder_input_data` & `decoder_input_data` into `decoder_target_data`
    model = Model([encoder_inputs, decoder_inputs], decoder_outputs)
    # plot the model
    plot_model(model, to_file='model.png', show_shapes=True)


def load_data(data_dir=None):
    data_dir = data_dir or os.path.join(os.path.sep + 'midata', 'viddesc')
    descriptions = pd.read_table(os.path.join(data_dir, 'LSMDC16_annos_training.csv'), header=None)
    descriptions.columns = 'filename start_2s end_2s start end description'.split()
    embeddings = load_embeddings(os.path.join(data_dir, 'embeddings'))
    wv = get_data('word2vec')
    return wv, descriptions, embeddings


if __name__ == '__main__':
    args = sys.argv[1:] if len(sys.argv) > 1 else []
    wv, descriptions, embeddings = load_data(*args)
