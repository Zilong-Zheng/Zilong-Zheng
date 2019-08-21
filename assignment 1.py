import re
import pandas as pd

def segmentation(file):
	result = re.findall(r'<\?xml[\d\D]*?</us-patent-grant>',file)
	return result
def find_grant_id(inputstring):
	grant_id = re.search(r'file="(.*)-\d*.XML"', inputstring)
	return grant_id.group(1)
def find_patent_title(inputstring):
	patent_title = re.search(r'<invention-title id=".*">(.*)</invention-title>', inputstring)
	return patent_title.group(1)
def find_kind(inputstring):
	kind_id = re.search(r'<publication-reference>[\d\D]*?<kind>(.*)</kind>', inputstring)
	if kind_id.group(1) == 'B2':
		kind_result = 'Utility Patent Grant (with a published application) issued on or after January 2, 2001.'
		return kind_result
	elif kind_id.group(1) == 'S1':
		kind_result = 'Design Patent'
		return kind_result
	elif kind_id.group(1) == 'E1':
		kind_result = 'Reissue Patent'
		return kind_result
	elif kind_id.group(1) == 'B1':
		kind_result = 'Utility Patent Grant (no published application) issued on or after January 2, 2001.'
		return kind_result
	elif kind_id.group(1) == 'P3':
		kind_result = 'Plant Patent Grant (with a published application) issued on or after January 2, 2001'
		return kind_result
	elif kind_id.group(1) == 'P2':
		kind_result = 'Plant Patent Grant (no published application) issued on or after January 2, 2001'
		return kind_result
def find_the_number_of_claims(inputstring):
	number_of_claims = re.search(r'<number-of-claims>(\d*)</number-of-claims>', inputstring)
	return number_of_claims.group(1)
def find_the_name(inputstring):
	inventors_name = ''
	inventors = re.findall(r'<inventor[\d\D]*?</inventor>', inputstring)
	for inventor in inventors:
		inventor_last_name = re.search(r'<last-name>(.*?)</last-name>', inventor)
		inventor_first_name = re.search(r'<first-name>(.*?)</first-name>', inventor)
		if inventor_last_name is None and inventor_first_name is None:
			inventor_name = 'NA'
		elif inventor_last_name is None:
			inventor_name = inventor_first_name.group(1)
		elif inventor_first_name is None:
			inventor_name = inventor_last_name.group(1)
		else:
			inventor_name = inventor_first_name.group(1) + ' ' + inventor_last_name.group(1)
		inventors_name = inventors_name + inventor_name + ','
	result = '[' + inventors_name[:-1] + ']'
	return result

def applicant_count(inputstring):
	count = re.findall(r'<category>.*applicant</category>', inputstring)
	return len(count)

def examiner_count(inputstring):
	count = re.findall(r'<category>.*examiner</category>', inputstring)
	return len(count)

def find_abstract(inputstring):
	abstract_tag = re.search('<abstract id="abstract">\n([\s\S]*?)\n</abstract>',inputstring)
	if abstract_tag is None:
		return 'NA'
	else:
		clean_abstract_2 = re.sub('\n', ' ', abstract_tag.group(1))
		return clean_abstract_2

def find_claim_text(inputstring):
	claim_text = re.findall('<claims id="claims">\n([\d\D]*?)\n</claims>', inputstring)
	if claim_text is None:
		return 'NA'
	else:
		clean_claim_text = ''
		for i in claim_text:
			clean_claim_text = clean_claim_text + i + ','
		clean_claim_text_3 = re.sub('\n', ' ', clean_claim_text)
		clean_claim_text_4 = '[' + clean_claim_text_3[:-1] + ']'
		return clean_claim_text_4

def writting_json (string_1, string_2,string_3, string_4, string_5, string_6, string_7, string_8, string_9):
	result = '"'+string_1+'":{"'+\
		'patent_title'+'":"'+string_2+'","'+\
		'kind'+'":"'+string_3+'","'+\
		'number_of_claims'+'":'+str(string_4)+',"'+\
		'inventors'+'":"'+string_5+'","'+\
		'citations_applicant_count'+'":'+str(string_6)+',"'+\
		'citations_examiner_count'+'":'+str(string_7)+',"'+\
		'claims_text'+'":"'+string_8+'","'+\
		'abstract'+'":"'+string_9+'"},'
	return result
def clean_tag (inputstring):
	tags = re.findall('</(.*?)>', inputstring)
	for tag in set(tags):
		pattern = '<' + tag + '.*?>'
		reg = re.compile(pattern)
		inputstring = reg.sub('', inputstring)
	inputstring = re.sub(r'</.*?>', '', inputstring)
	inputstring = re.sub(r'<\?.*?\?>','', inputstring)
	inputstring = re.sub(r'<.*?/>', '', inputstring)
	return inputstring



file = open('Group146.txt').read()
json_file = open('Group146.json', 'w')
content = segmentation(file)
json = ''
df = pd.DataFrame(columns = ['grant_id', 'patent_title','kind', 'number_of_claims', 'inventors', 'citations_applicant_count', 'citations_examiner_count', 'claims_text', 'abstract'])
for part in content:
	grant_id = find_grant_id(part)
	patent_title = find_patent_title(part)
	kind = find_kind(part)
	number_of_claims = find_the_number_of_claims(part)
	inventors = find_the_name(part)
	citation_applicant_count = applicant_count(part)
	citations_examiner_count = examiner_count(part)
	claims_text = clean_tag(find_claim_text(part))
	abstract = clean_tag(find_abstract(part))
	json_row = writting_json(grant_id, patent_title, kind, number_of_claims, inventors, citation_applicant_count, citations_examiner_count, claims_text, abstract)
	json += json_row
	df = df.append(pd.DataFrame({'grant_id': [grant_id], 'patent_title':[patent_title],'kind':[kind], 'number_of_claims':[number_of_claims], 'inventors':[inventors], 'citations_applicant_count':[citation_applicant_count], 'citations_examiner_count':[citations_examiner_count], 'claims_text':[claims_text], 'abstract':[abstract]}), ignore_index=True)
df.to_csv('Group146.csv', index=False)
json_content = '{'+json[:-1]+'}'
json_file.write(json_content)
json_file.close()







