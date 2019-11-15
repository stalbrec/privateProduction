#!/usr/bin/env python3
import os
from condor_submission import GENSIM
from optparse import OptionParser

parser = OptionParser()
parser.add_option('--submit', action='store_true',default=False, dest='submit',help='Submit jobs')
parser.add_option('--clean', action='store_true',default=False, dest='clean',help='Delete workdirs')
(options, args) = parser.parse_args()

print("preparing scripts and workdirs for submission of GENSIM sample production...")
gridpack_path = '/nfs/dust/cms/user/albrechs/aQGCModelComparison/genproductions/bin/MadGraph5_aMCatNLO/'
gridpack_suffix = '_slc6_amd64_gcc630_CMSSW_9_3_16_tarball.tar.xz'

names=[
    # 'aQGC_ZhadZhadJJ_newModel_QED2_QCD0_4f',
    # 'aQGC_ZhadZhadJJ_newModel_QED2_QCD0_5f',
    # 'aQGC_ZhadZhadJJ_oldModel_QED2_QCD0_4f',
    # 'aQGC_ZhadZhadJJ_oldModel_QED2_QCD0_5f',
    # 'aQGC_ZhadZhadJJ_newModel_QED2_QCD0_4f_varyOnlyPDF',
    # 'aQGC_ZhadZhadJJ_newModel_QED2_QCD0_5f_varyOnlyPDF',
    # 'aQGC_ZhadZhadJJ_oldModel_QED2_QCD0_4f_varyOnlyPDF',
    # 'aQGC_ZhadZhadJJ_oldModel_QED2_QCD0_5f_varyOnlyPDF',
    'aQGC_ZhadZhadJJ_newModel_QED4_QCD0_4f',
    'aQGC_ZhadZhadJJ_newModel_QED4_QCD0_5f',
    'aQGC_ZhadZhadJJ_oldModel_QED4_QCD0_4f',
    'aQGC_ZhadZhadJJ_oldModel_QED4_QCD0_5f'
]

workdir='/nfs/dust/cms/user/albrechs/aQGCModelComparison/SM_aQGC_samples/'

if(options.clean):
    print('deleting workdir..')
    os.system("rm -rf "+workdir)
    exit(0)

for name in names:
    g = GENSIM(name,workdir+name,gridpack=gridpack_path+name+gridpack_suffix,number_jobs=100,events=10000)
    if(options.submit):
        g.submit_jobs()
