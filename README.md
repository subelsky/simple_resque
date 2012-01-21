# Simple Resque

I needed a simple way to queue Resque jobs from a web app where the jobs were defined in a separate "worker"
codebase, running completely independently from the web app. Unfortunately,
Resque requires you to pass the class name of a job as a constant, when what I
really needed was to pass a string which would get turned into a constant class
name by the worker codebase. The gem assumes that the queue name is an
underscored version of the class name.

I had to do this enough times that I decided to wrap the idiom in a gem, figuring that over time
I'll need to add other simplifications of the Resque API.

# Installation

    gem install simple_resque

# Usage

    require 'simple_resque'

    # puts a job on the transmogrifier queue with class "Transmogrifier" and
    # arguments { id: 3, state: "back_to_calvin" }

    SimpleResque.push("Transmogrifier",id: 3, state: "back_to_calvin")

# Configuration

    SimpleResque.resque = Resque
    SimpleResque.resque = MyResqueMock # useful for unit testing

# Problems? Questions?

Email <mike@subelsky.com> or file an issue on
[GitHub](https://github.com/subelsky/simple_resque).

Patches are welcome. Thanks!

# License

See `MIT-LICENSE` for details.