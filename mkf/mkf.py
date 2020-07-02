#!/usr/bin/env python3
import os
import sys
import argparse

def createParser():
    parser = argparse.ArgumentParser()
    parser.add_argument ('-t', '--template', nargs='?')
    parser.add_argument ('-n', '--name', nargs='?')
    parser.add_argument ('-p', '--path', nargs='?', default=os.getcwd())

    return parser

########## MAIN
if __name__ == '__main__':
    absolute_path = '/mnt/d/CS/Dev/Utilities/mkf'
    name = ''
    template = ''
    path = os.getcwd()

    if (len(sys.argv) == 3):
        template = sys.argv[1]
        name = sys.argv[2]
    elif (len(sys.argv) > 3):
        parser = createParser()
        namespace = parser.parse_args(sys.argv[1:])
    
        template = namespace.template
        name = namespace.name
        path = namespace.path
    else:
        print('ERROR: Too few arguments...')
        exit()

    if (not (template in os.listdir(absolute_path + '/templates/'))):
        print('ERROR: Selected template is not exist...')
        exit()
    
    src =  absolute_path + '/templates/' + template
    dest = path + '/' + name

    #os.system('xcopy {src} {dest} /I /E'.format(src=src, dest=dest))
    os.system('cp -r {src} {dest}'.format(src=src, dest=dest))

    os.chdir(dest + '/source')
    print(os.getcwd())
    print(os.listdir())

    with open(template + '.sln') as file_in:
        text = file_in.read()

    text = text.replace('\"{}\"'.format(template), '\"{}\"'.format(name))
    text = text.replace('\"{}.vcxproj\"'.format(template), '\"{}.vcxproj\"'.format(name))

    with open(name + '.sln', "w") as file_out:
        file_out.write(text)

    os.remove(template + '.sln')

    os.rename(template + '.vcxproj', name + '.vcxproj')
    os.rename(template + '.vcxproj.filters', name + '.vcxproj.filters')
    os.rename(template + '.vcxproj.user', name + '.vcxproj.user')