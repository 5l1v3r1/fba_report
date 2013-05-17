Please note: This project is still in a continual flux right now, and should by no means be considered anything remotely stable.


FBA Reports
===========

Since I haven't been able to find the kind of reporting tools on Amazon that I wanted for Fulfillment-by-Amazon items, I made my own. It's just a database using ActiveRecord, with some command line tools to add to it or generate reports. As an input, it takes Fulfillment Reports generated by Amazon's Seller website.

This program is designed to be easily called from another directory, if you desire, and ideally, it should be a Gem, but it hasn't made it that far yet. I keep it in a subdir off of the path where I keep my order exports from Amazon.


Requirements
------------
- [activerecord](http://rubygems.org/gems/activerecord)
- a database (and interface) compatible with activerecord (right now, only [sqlite3](http://rubygems.org/gems/sqlite3) is supported, I think)


The Database
------------
The database is interfaced with by way of ActiveRecord. So far, only SQLite is implemented, since that's all I've been using, but aside from a few things in the Rakefile that aren't necessary, getting it to work with another database that ActiveRecord supports shouldn't be too hard at all (and might even be just a simple config change).


The Command Line Tools
----------------------
There are three command line tools provided: `load_data.rb`, `model_info.rb`, and `show_report.rb`. Mostly, they do what their names say.

### load_data.rb

This puts the data into the database. As an input, it takes Fulfillment Reports generated by Amazon's Seller website. It filters out non-FBA orders, so you don't need to worry about that. By default, it will not overwrite orders already imported into the database.

Here's the help (generated with `load_data.rb --help`):

```
Usage: load_data.rb [options] INPUTFILE

Specific options:
    -f, --force                      Force re-importing of pre-existing info
    -a, --[no-]archive               Archive input file after import
    -v, --[no-]verbose               Run verbosely

Common options:
    -h, --help                       Show this message
```


### model_info.rb

This simply shows some info about the table:

- Table attributes
- Number of records in the table
- Earliest purchase date of any of the items in the table
- Latest purchase date of any of the items in the table

There is only one option (`-a` or `--all`) which shows every single record in the table. As such, please use with caution.


### show_report.rb

This generates a report. Right now the only kind of report it generates is a simple report with SKUs along the x-axis, dates along the y-axis, and sales-per-date in each cell. By default, HTML table based reports are generated, but you can set an option to generate CSVs or TSVs if you wish (handy for importing into something else). Also with command line options, you can select different time periods to report, and you can select which specific SKUs to report.

Here's the help (generated with `show_report.rb --help`):

```
Usage: show_report.rb [options]

Spans and offsets (can be combined):
    -d, --span-day DAYS              Length of report in days
    -w, --span-week WEEKS            Length of report in weeks
    -m, --span-month MONTHS          Length of report in months
    -y, --span-year YEARS            Length of report in years
        --offset-day DAYS            Offset of report in days
        --offset-week WEEKS          Offset of report in weeks
        --offset-month MONTHS        Offset of report in months
        --offset-year YEARS          Offset of report in years

Misc options:
    -i, --interval INTERVAL          The smallest time period to display in report
                                       (daily, weekly, monthly, yearly)
    -s, --skus sku1,sku2,sku3        Include only specific skus in report
    -f, --format TYPE                The format of output to generate
                                       (html, csv, tsv)
    -o, --output FILENAME            The name of the file to output to
                                       (if none specified, outputs to stdout)
    -v, --[no-]verbose               Run verbosely
    -a, --all                        Report on entire timespan in database
                                       (overrides spans and offsets)
    -h, --help                       Show this message
        --dry-run                    Only show start and end dates, no report
```


### rake

There are also a few useful database-specific tasks in the Rakefile:

```
rake db:drop     # Drop the db
rake db:info     # Show info about all tables in db
rake db:migrate  # Migrate the db
rake db:reset    # Reset the db
```


License
-------
Please see [LICENSE.txt](LICENSE.txt).

