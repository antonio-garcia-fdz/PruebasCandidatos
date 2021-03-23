import json
import xml
from dicttoxml import dicttoxml
from csv import reader
from xml.dom.minidom import parseString

# list to store the dictionaries for categories and products
categories = []

# open Categories file in read mode
with open('Categories.csv', 'r') as categories_file:
    # get the reader object
    csv_reader = reader(categories_file, delimiter= ';')
    # skip first row (column names)
    next(csv_reader)
    # Iterate over each row in the csv using reader object
    for row in csv_reader:

        # create a dictionary for each category
        category = {}
        category['Id'] = int(row[0])
        category['Name'] = row[1]
        category['Description'] = row[2]
        # with a field as an empty array for the products
        category['Products'] = []

        # add the category dictionary to the list
        categories.append(category)


# open Products file in read mode
with open('Products.csv', 'r', encoding = "ISO-8859-1") as products_file:
    # get the reader object
    csv_reader2 = reader(products_file, delimiter= ';')
    # skip first row (column names)
    next(csv_reader2)
    # Iterate over each row in the csv using reader object
    for row in csv_reader2:

        # create a dictionary for each category
        product = {}
        product['Id'] = int(row[0])
        product['CategoryId'] = int(row[1])
        product['Name'] = row[2]
        product['Price'] = float(row[3].replace(',','.'))

        # add the product dictionary to the list that corresponds with its category
        categories[product['CategoryId']-1]['Products'].append(product)


# open json file in write mode
with open('result.json', 'w') as jsonfp:
    # covert the dictionary list and write it in the json file
    json.dump(categories, jsonfp, indent=2)



# open xml file in write mode
with open('result.xml', 'w') as xmlfp:
    # covert the dictionary list
    xml = dicttoxml(categories, custom_root='ArrayOfCategory', attr_type=False)
    # write it in the xml file
    xmlfp.write(parseString(xml).toprettyxml())
