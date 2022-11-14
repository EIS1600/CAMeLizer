# requires Python 3.8 (CAMeL Tools do not work with later versions of Python)

import os, re

sourceFolder = "./texts/"
targetFolder = "./results_raw/"

from openiti.helper.ara import deNoise

##### CAMEL TOOLS FUNCTION ###########################################################
from camel_tools.tokenizers.word import simple_word_tokenize
from camel_tools.disambig.bert import BERTUnfactoredDisambiguator
unfactored = BERTUnfactoredDisambiguator.pretrained()

# TOKEN, TOKEN_VOC, POS, LEMMA, LEMMA_VOC
def intoTSV(fileName, text):
    section = simple_word_tokenize(text)
    disambig = unfactored.disambiguate(section)

    lemmas = [d.analyses[0].analysis['lex'] for d in disambig]
    pos_tags = [d.analyses[0].analysis['pos'] for d in disambig]
    diacritized = [d.analyses[0].analysis['diac'] for d in disambig]

    final = []

    for i in range(0, len(lemmas), 1):
        token = deNoise(diacritized[i])
        tokenVoc = diacritized[i]
        pos = pos_tags[i]
        lemma = deNoise(lemmas[i])
        lemmaVoc = lemmas[i]

        row = "\t".join([fileName, token, tokenVoc, pos, lemma, lemmaVoc])
        final.append(row)
    return(final)

#example = "أبو الحسن آدم ابن أبي اياس T1 العسقلاني T1 خراساني الأصل سكن T1 عسقلان ونسب إليها وصحب شعبة ابن الحجاج T1 بالبصرة . هو من مشايخ البخاري . توفى سنة 220 عشرين ومائتين من الهجرة ."
#input(intoTSV(example))

filesToProcess = os.listdir(sourceFolder)

header = "\t".join(["fileName", "TOKEN", "TOKEN_VOC", "POS", "LEMMA", "LEMMA_VOC"])
allResults = [header]

for f in filesToProcess:
    if not f.startswith(".") and f.endswith(".txt"):
        print(f)
        with open(sourceFolder + f, "r", encoding="utf8") as f1:
            textTemp = f1.read()
            textTemp = re.sub("[\"\']", "", textTemp)

            tsvResults = intoTSV(f, textTemp)

            allResults.extend(tsvResults)

            with open(targetFolder + f.replace(".docx.txt", ".tsv"), "w", encoding="utf8") as f9:
                f9.write(header + "\n" + "\n".join(tsvResults))

with open(targetFolder + "all_results.tsv", "w", encoding="utf8") as f9:
    f9.write("\n".join(allResults))