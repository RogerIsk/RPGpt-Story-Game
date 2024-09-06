from urllib.request import urlopen
from bs4 import BeautifulSoup
import json

""" create a dictionary with random website """

quote_page = 'https://jonasjacek.github.io/colors/'

page = urlopen(quote_page)
print("PAGE type", page.info().get('Content-Encoding'))
soup = BeautifulSoup(page, 'html.parser')
cd = {}
for a in soup.find_all('tr'):
    term = a.contents[1].contents[0]
    name = a.contents[2].contents[0]
    chex = a.contents[3].contents[0]
    rgb = a.contents[4].contents[0]
    hsl = a.contents[5].contents[0]
    cd[term] = {"term":term, "name":name, "hex":chex, "rgb":rgb, "hsl":hsl}

#with open('colordict.py', 'w+') as the_file:
#   the_file.write(json.dumps(cd))
