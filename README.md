We are trying to find the fastest algorithm for finding all the
two-word anagrams of the word 'documenting'.

To install the prerequisites, run:

    gem install bundler
    bundle

To choose which algorithm you want to work on, run one of:

    export ALGORITHM=kata
    export ALGORITHM=david
    export ALGORITHM=josh

Alternatively, you can prepend "ALGORITHM=name" to any of the
other commands listed in this documentation.

While you are developing an algorithm, test it for correctness
by running:

    watchr watch.rb

or

    rspec spec.rb

Test it for speed and correctness by running:

    time ./go.rb

Figure out how to speed it up by running ruby-prof (which adds significant overhead):

    ruby-prof go.rb

