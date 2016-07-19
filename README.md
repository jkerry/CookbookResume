# CookbookResume - continuously delivering my resumé

I've long compiled my resumé in LaTeX and I've wanted a way to put it right into public source control. A desire to hide sensitive information has led me astray for a long while but no longer! Through flagrant overengineering and misuse of powerful technology ( *Chef*, *Inspec* ) this is no longer an issue.

## Delivery Flow

On check-in this cookbook is invoked via *test-kithen* which spins up an ubuntu
build agent node. The default recipe:
* handles bootstrapping the tex environment
* templating the LaTeX source document
* dropping images
* compiling LaTeX to PDF,
* (optionally) distribution to a keyed SSH server.

In practice this repository is watched via jenkins and an obscured info build
is compiled and released to kerryhouse.net upon change.

## Resume Customization

Even though we are always qualified for every job we want and this fact is
immediately evident by our mere presence we occasionally need to customize our
our CV for the job at hand.  This is accomplished by carving out feature branches off of master and makign whatever customizations are needed. Jenkins should then do a
non-deliverable build with real contact information.
