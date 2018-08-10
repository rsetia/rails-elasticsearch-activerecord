# README

Queries relational data using Elasticsearch and ActiveRecord. 

## Ruby version

2.5.1

## Local development

1. Launch dockerized dependencies 

```
docker-compose up
```

2. Load data. The script will remove any data that breaks foreign key rules to
   enforce consistency

```
rails runner scripts/load_data.rb
```

3. Query the data

```
$ rails runner scripts/search.rb -h

Usage: search.rb [options]
    -s, --scope SCOPE                Search scope (organizations, users, tickets)
    -f, --field FIELD                Field to search within the scope
    -v, --value VALUE                Value to search within the field
```

Example: 

```
$ rails runner scripts/search.rb -s organizations -f id -v 101

[{"id":101,"url":"http://initech.zendesk.com/api/v2/organizations/101.json","external_id":"9270ed79-35eb-4a38-a46f-35725197ea8d","name":"Enthaze","created_at":"2016-05-21T21:10:28.000Z","details":"MegaCorp","shared_tickets":false,"domain_names":["kage.com","ecratic.com","endipin.com","zentix.com"],"tags":["Fulton","West","Rodriguez","Farley"],"users":["Loraine
Pittman","Francis Bailey","Haley Farmer","Herrera Norman"],"tickets":["A Problem
in Guyana","A Problem in Turks and Caicos Islands","A Drama in Portugal","A
Problem in Ethiopia"]}]
```


## Improvements 

- Convert search.rb script into an interactive interface
- complete specs
- for scalability, expose data via a Rails web app 
