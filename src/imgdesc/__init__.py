# -*- coding: utf-8 -*-
from pkg_resources import get_distribution, DistributionNotFound

try:
    # Change __name__ here if project is renamed and does not equal # the package name
    dist_name = 'viddesc'  # imgdesc?
    __version__ = get_distribution(dist_name).version
except DistributionNotFound:
    __version__ = 'unknown'
