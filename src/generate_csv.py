import xml.etree.ElementTree as ET
import os

exit_please = 0

# Dataset directory
directory = "../dataset/hackathon-for-good-2019_TWB-challenge_files"

# Generated dataset
hackforgood_dataset_csv = "filename, sourcelang, targetlang, sourcetext, targettext\n"

for filename in os.listdir(os.path.abspath(directory)):
    if filename.endswith(".sdlxliff"):
        file_path = os.path.join(directory, filename)

        doc_tree = ET.parse(file_path)

        # CSV collumns

        file_nodes = doc_tree.findall(".//{urn:oasis:names:tc:xliff:document:1.2}file")

        sourcelang = file_nodes[0].attrib.get('source-language')

        targetlang = file_nodes[0].attrib.get('target-language')

        sourcetext = ""
        
        sourcetext_list = doc_tree.findall(".//{urn:oasis:names:tc:xliff:document:1.2}source")

        for elem in sourcetext_list:
                for elem in elem.iter():
                        if elem.text is not None: 
                                sourcetext = sourcetext + " " + elem.text
        
        targettext = ""

        targettext_list = doc_tree.findall(".//{urn:oasis:names:tc:xliff:document:1.2}target")

        for elem in targettext_list:
                for elem in elem.iter():
                        if elem.text is not None: 
                                targettext = targettext + " " + elem.text

        hackforgood_dataset_csv = hackforgood_dataset_csv + "\"{}\", {}, {}, \"{}\", \"{}\"\n".format(filename, sourcelang, targetlang, sourcetext, targettext) 
        
        exit_please = exit_please + 1
        if exit_please > 500:
                hackforgood_dataset_csv_file = open("../dataset/hackforgood_dataset.csv", "w")
                hackforgood_dataset_csv_file.write(hackforgood_dataset_csv)
                hackforgood_dataset_csv_file.close()
                exit()