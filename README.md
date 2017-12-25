# twenty_forty_eight

This is a ported version of my implementation of [2048 in Ruby](https://rubygems.org/gems/TwentyFortyEight)
It only implements a small subset of its functionality at the moment, I decided to create a port because
I wanted to have some fun with a compiled language for a change and Crystal so far has been awesome to write in!

A next step will be to add a TUI so that one can play the game within a terminal, using keys to move, quit and restart

## Installation

To install, add it as a dependency to your `shards.yml`:

```
dependencies:
    twenty_forty_eight:
        github: SidOfc/2048-crystal
        branch: master
```

## Usage

After installing, the module `TwentyFortyEight` will be available to use.
See the [documentation](https://sidofc.github.io/2048-crystal) for more details.

## Contributing

1. Fork it ( https://github.com/SidOfc/twenty_forty_eight/fork )
2. Create your feature branch (git checkout -b my-new-feature)
3. Commit your changes (git commit -am 'Add some feature')
4. Push to the branch (git push origin my-new-feature)
5. Create a new Pull Request

## Contributors

- [SidOfc](https://github.com/SidOfc) Sidney Liebrand - creator, maintainer
