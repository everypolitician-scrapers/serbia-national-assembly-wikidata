#!/bin/env ruby
# encoding: utf-8

require 'wikidata/fetcher'

en_names = EveryPolitician::Wikidata.wikipedia_xpath( 
  url: 'https://en.wikipedia.org/wiki/List_of_current_members_of_the_National_Assembly_of_Serbia',
  xpath: '//table[.//th[contains(.,"Party")]]//tr//td[1]//a[not(@class="new")][1]/@title',
) 

sr_names = WikiData::Category.new('Категорија:Народни посланици Скупштине Србије', 'sr').member_titles

EveryPolitician::Wikidata.scrape_wikidata(names: { en: en_names, sr: sr_names })

