test-reportgen
==============

A simple attempt on how to use LaTeX to generate multi-page lists/reports.

## Usage ##
 * use `gen_db.sh` to generate the database schema
 * use `fill_db.pl` to fill database table with dummy data
 * use `generate.sh` to create the output named **report.pdf**;
   this invokes `gen_rep.pl` to generate `report-data.tex` and calls pdflatex on the file `report.tex` afterwards
   
   
## Requirements ##
  * LaTeX with
    * pdflatex
    * KOMA script classes
    * package longtable
    * German language support (Ubuntu package `texlive-lang-german`)
  * Perl with
    * libdbd-sqlite3-perl
  * Bash
  * SQLite3
