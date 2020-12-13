import argparse
from fnmatch import fnmatch
import os
import sys
from collections import OrderedDict


def main(argv):
    abs_path = os.path.expanduser('~/Desktop')
    od = OrderedDict()
    file_name_root = argv.current_file_name[: argv.current_file_name.find('_')]
    file_name_number = int(argv.current_file_name[argv.current_file_name.find('_') + 1 : ])
    for f in os.listdir(abs_path):
        if fnmatch(f, '螢幕快照*.png'):
            mtime = os.stat(
                os.path.join(abs_path, f)
            ).st_mtime
            od[mtime] = f

    for _, f in od.items():
        new_file_name = file_name_root + '_' + str(file_name_number + 1) + '.png'
        if os.path.exists(os.path.join(abs_path, new_file_name)):
            file_name_number += 1
        
        os.rename(os.path.join(abs_path, f), os.path.join(abs_path, new_file_name))
        file_name_number += 1

def parse_arguments(argv):
    parser = argparse.ArgumentParser()
    parser.add_argument('current_file_name',
        help='e.g. segmentation_14')
    return parser.parse_args(argv)

if __name__ == '__main__':
    debug = False
    if debug:
        debug_param = ['abc_142']
        sys.argv.extend(debug_param)
    print(sys.argv) #debug
    main(parse_arguments(sys.argv[1:]))

