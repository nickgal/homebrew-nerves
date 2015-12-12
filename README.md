# homebrew-nerves

This tap contains a formulae related to Nerves as well as a command line interface for fetching appropriate packages and creating projects.

Install

    # Add the tap to homebrew
    brew tap nerves-project/nerves

    # View help
    brew nerves --help

    Usage:
      brew nerves get PLATFORM         # Install requirements for Nerves development with given PLATFORM
      brew nerves new PLATFORM PATH    # Create a new Nerves project at PATH set to target PLATFORM
      brew nerves set PLATFORM         # Set existing project in current directory to target PLATFORM

    Platforms:
      bbb                            # Beaglebone Black
      rpi                            # Original Raspberry Pi
      rpi2                           # Raspberry Pi 2
