import pandas as pd
import xml.etree.cElementTree as et
# noinspection PyUnresolvedReferences
import nltk
# noinspection PyUnresolvedReferences
from nltk.corpus import stopwords
import glob
from sklearn.feature_extraction.text import TfidfTransformer, CountVectorizer
import re
from nltk.stem import WordNetLemmatizer
from nltk import word_tokenize
from sklearn import svm
# read the training data set and test data set
train=pd.read_csv('train_labels.csv')
test=pd.read_csv('test.csv')
# scan the xml file in data folder
all_file = glob.glob('./data/*xml')
all_document = {}
# read the xml file
for file in all_file:
    xml_tree = et.ElementTree(file = file)
    root = xml_tree.getroot()
    document = ''
    for sub_node in root:
        for node in sub_node:
            sentence = node.text
            document += sentence
    all_document[file[7:]] = document
# create a data frame to store the xml file name, twitter content and feature
df_without_feature = pd.DataFrame(columns=['id', 'content', 'feature'])
id_list = []
content_list = []
# process the data
for i in all_document.keys():
    # change the URL link to URL string
    all_document[i] = re.sub(r'\b(([\w-]+://?|www[.])[^\s()<>]+(?:[\w\d]+[\w\d]+|([^[:punct:]\s]|/)))', 'URL', all_document[i])
    # change the user's @ to @username string
    all_document[i] = re.sub(r'@[\w\W]*?\s', '@username ', all_document[i])
    # remove the .xml in i
    id_name = i.replace('.xml', '')
    id_list.append(id_name)
    content_list.append(all_document[i])
df_without_feature['id'] = id_list
df_without_feature['content'] = content_list

# Stemming and Lemmatization
class LemmaTokenizer(object):
    def __init__(self):
        self.wnl = WordNetLemmatizer()

    def __call__(self, doc):
        return [self.wnl.lemmatize(t) for t in word_tokenize(doc)]

content_row = df_without_feature['content'].tolist()
vectorizer = CountVectorizer(analyzer='word', input='content',
                             lowercase=True, # change to the lowercase
                             token_pattern='(?u)\\b\\w\\w+\\b',
                             min_df=0.05, # Removed the first 5% of words and the last 5% of words
                             max_df=0.95, # Removed the first 5% of words and the last 5% of words
                             stop_words='english', # remove the stop word
                             ngram_range=(1, 3), # tripe gram
                             tokenizer=LemmaTokenizer() # tokenizer
                            )
X = vectorizer.fit_transform(content_row)
# calculate the tf-idf value for each the whole vocabulary
transformer = TfidfTransformer()
result = transformer.fit_transform(X)
# transfer the result to list
result_list = result.toarray().tolist()
# put the feature into the feature column
df_without_feature['feature'] = result_list
# Select features in all train data
train_with_feature = pd.merge(train, df_without_feature, how='left', on=['id'])
# replace the male with 1 and female with 2
for i in train_with_feature.index.values:
    if train_with_feature.loc[i,'gender'] == 'male':
        train_with_feature.loc[i,'gender'] = 1
    if train_with_feature.loc[i,'gender'] == 'female':
        train_with_feature.loc[i,'gender'] = 0
# select feature in all test data
test_with_feature = pd.merge(test, df_without_feature, how='left', on=['id'])
# create the svm model
svm_model = svm.SVC(C=1.0, break_ties=False, cache_size=200, class_weight=None, coef0=0.0,
           decision_function_shape='ovr',degree=3, gamma='auto', kernel='linear', max_iter=-1, probability=False,
           random_state=None, shrinking=True,
           tol=0.001, verbose=False)
# fit the svm model
svm_model.fit(train_with_feature['feature'].tolist(), train_with_feature['gender'].tolist())
# predict the result
svm_predict = svm_model.predict(test_with_feature['feature'].tolist())
# put the predict result into the data frame
test_with_feature['gender'] = svm_predict.tolist()
result = test_with_feature[['id','gender']]
# transfer the 1 to male and 0 to female
for j in result.index.values:
    if result.loc[j,'gender'] == 1:
        result.loc[j,'gender'] = 'male'
    if result.loc[j,'gender'] == 0:
        result.loc[j,'gender'] = 'female'
# put the data frame into csv file
result.to_csv('predict_label.csv', index = False)
