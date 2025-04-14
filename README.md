agrirouter end user documentation

The agrirouter is a universal data exchange platform for farmers and agricultural contractors that makes it possible to connect machinery and agricultural software, 
regardless of vendor or manufacturer. agrirouter does not save data; it transfers data. As a universal data exchange platform, agrirouter fills a gap on the way to Farming 4.0. 
Its underlying concept unites cross-vendor and discrimination-free data transfer. You retain full control over your data. Even data exchange with service providers 
(e.g. agricultural contractors) and other partners is uncomplicated: Data are very rapidly transferred via the online connection, and if you wish, 
is intelligently connected to other datasets.

This is a repository for the end user documentation.

## maintenance tasks

### preview & production deployment

Preview deployments will automatically be deployed for every pull request and for pushes on ´main´.

 * For Pull Requests, the preview URL will be commented in the PR discussion.
 * For Main, the URL is fixed to https://manual.agrirouter.com/_branches/main.

Production deployments are triggered by creating a new Github release. For name, we are using YYYYMMDD\[-#\], with -# being an optional suffix in case we have multiple releases on a given day.


### add new documents

New pages always have to first be added in English!

If you want to add new pages to the documentation, follow these steps:

* add a file called `pagetitle.adoc` under [en/modules/ROOT/pages](en/modules/ROOT/pages), you can create subdirectories there
* add an entry in [en/modules/ROOT/nav.adoc](en/modules/ROOT/nav.adoc) to make navigation to that page possible
* add an entry in [po4a.conf](po4a.conf) (this configures the translation process to include that file)
* after running po4a, have someone translate the respective `.po` files under [translations](translations) (or do it yourself ;) )

### edit existing documents

English is the primary language of this documentation.

This means that all structural editing, creating new pages etc. always has to start in English.

If you just want to edit existing pages:
* for English, just edit the respective `.adoc` file
* for all other languages, edit the respective `.po` file under [translations](translations)
* during the build process, all necessary updates and generating of the non-English files will be done

### add new language

To add a new language, the following steps have to be done:

* create the directory to contain all files for that language using its two-letter-code, e.g. ko for Korean
* add the language to po4a.conf, in the line "[po4a_langs]"
* after running po4a, have someone translate the respective `.po` files under [translations](translations) (or do it yourself ;) )
