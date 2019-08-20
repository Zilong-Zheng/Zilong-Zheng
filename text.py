import re
file = open('test.txt').read()
part = re.findall('<\?xml([\d\D]*?)</us-patent-grant>',file)
for one_part in part:
    inventors = re.findall('<inventor([\d\D]*?)</inventor>', one_part)
    for inventor in inventors:
        inventor_last_name = re.search('<last-name>(.*?)</last-name>', inventor)
        inventor_first_name = re.search('<first-name>(.*?)</first-name>',inventor)
        if inventor_last_name is None and inventor_first_name is None:
            print('NA')
        elif inventor_last_name is None:
            print(inventor_first_name.group(1))
        elif inventor_first_name is None:
            print(inventor_last_name.group(1))
        else:
            print(inventor_last_name.group(1) +' '+ inventor_first_name.group(1))
