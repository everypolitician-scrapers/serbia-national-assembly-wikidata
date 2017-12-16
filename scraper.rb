#!/bin/env ruby
# encoding: utf-8

require 'wikidata/fetcher'

en = {}

en['current'] = EveryPolitician::Wikidata.wikipedia_xpath( 
  url: 'https://en.wikipedia.org/wiki/List_of_current_members_of_the_National_Assembly_of_Serbia',
  xpath: '//table[.//th[contains(.,"Party")]]//tr//td[1]//a[not(@class="new")][1]/@title',
)

en['2012'] = EveryPolitician::Wikidata.wikipedia_xpath( 
  url: 'https://en.wikipedia.org/wiki/List_of_members_of_the_National_Assembly_of_Serbia,_2012–2014',
  xpath: '//table[.//th[contains(.,"Party")]]//tr//td[1]//a[not(@class="new")][1]/@title',
)

en['2008'] = EveryPolitician::Wikidata.wikipedia_xpath( 
  url: 'https://en.wikipedia.org/wiki/List_of_members_of_the_National_Assembly_of_Serbia,_2008–2012',
  xpath: '//table[.//th[contains(.,"Party")]]//tr//td[1]//a[not(@class="new")][1]/@title',
)

sr_names = WikiData::Category.new('Категорија:Народни посланици Скупштине Србије', 'sr').member_titles

sparq = 'SELECT DISTINCT ?item WHERE { ?item p:P39 [ ps:P39 wd:Q21295999 ; pq:P2937 wd:Q30155066 ] }'
ids = EveryPolitician::Wikidata.sparql(sparq)

EveryPolitician::Wikidata.scrape_wikidata(ids: ids, names: { en: en.values.inject(&:|), sr: sr_names })

