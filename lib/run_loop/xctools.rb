require 'open3'
require 'retriable'

module RunLoop

  # @deprecated Since 1.5.0
  #
  # The behaviors of this class are in the process of being refactored to other
  # classes.  Please do not implement any new behaviors in this class.
  #
  # Callers should be updated ASAP.
  #
  # A class for interacting with the Xcode tools.
  #
  # @note All command line tools are run in the context of `xcrun`.
  #
  # Throughout this class's documentation, there are references to the
  # _current version of Xcode_.  The current Xcode version is the one returned
  # by `xcrun xcodebuild`.  The current Xcode version can be set using
  # `xcode-select` or overridden using the `DEVELOPER_DIR`.
  #
  # @todo Refactor instruments related code to instruments class.
  class XCTools

    # @deprecated Since 1.5.0 - replaced with RunLoop::Xcode
    # Returns a version instance for `Xcode 7.1`; used to check for the
    # availability of features and paths to various items on the filesystem.
    #
    # @return [RunLoop::Version] 7.1
    def v71
      RunLoop.deprecated('1.5.0', 'Replaced with RunLoop::Xcode') if RunLoop::Environment.debug?
      xcode.v71
    end

    # @deprecated Since 1.5.0 - replaced with RunLoop::Xcode
    # Returns a version instance for `Xcode 7.0`; used to check for the
    # availability of features and paths to various items on the filesystem.
    #
    # @return [RunLoop::Version] 7.0
    def v70
      RunLoop.deprecated('1.5.0', 'Replaced with RunLoop::Xcode') if RunLoop::Environment.debug?
      xcode.v70
    end

    # @deprecated Since 1.5.0 - replaced with RunLoop::Xcode
    # Returns a version instance for `Xcode 6.4`; used to check for the
    # availability of features and paths to various items on the filesystem.
    #
    # @return [RunLoop::Version] 6.4
    def v64
      RunLoop.deprecated('1.5.0', 'Replaced with RunLoop::Xcode') if RunLoop::Environment.debug?
      xcode.v64
    end

    # @deprecated Since 1.5.0 - replaced with RunLoop::Xcode
    # Returns a version instance for `Xcode 6.3`; used to check for the
    # availability of features and paths to various items on the filesystem.
    #
    # @return [RunLoop::Version] 6.3
    def v63
      RunLoop.deprecated('1.5.0', 'Replaced with RunLoop::Xcode') if RunLoop::Environment.debug?
      xcode.v63
    end

    # @deprecated Since 1.5.0 - replaced with RunLoop::Xcode
    # Returns a version instance for `Xcode 6.2`; used to check for the
    # availability of features and paths to various items on the filesystem.
    #
    # @return [RunLoop::Version] 6.2
    def v62
      RunLoop.deprecated('1.5.0', 'Replaced with RunLoop::Xcode') if RunLoop::Environment.debug?
      xcode.v62
    end

    # @deprecated Since 1.5.0 - replaced with RunLoop::Xcode
    # Returns a version instance for `Xcode 6.1`; used to check for the
    # availability of features and paths to various items on the filesystem.
    #
    # @return [RunLoop::Version] 6.1
    def v61
      RunLoop.deprecated('1.5.0', 'Replaced with RunLoop::Xcode') if RunLoop::Environment.debug?
      xcode.v61
    end

    # @deprecated Since 1.5.0 - replaced with RunLoop::Xcode
    # Returns a version instance for `Xcode 6.0`; used to check for the
    # availability of features and paths to various items on the filesystem.
    #
    # @return [RunLoop::Version] 6.0
    def v60
      RunLoop.deprecated('1.5.0', 'Replaced with RunLoop::Xcode') if RunLoop::Environment.debug?
      xcode.v60
    end

    # @deprecated Since 1.5.0 - replaced with RunLoop::Xcode
    # Returns a version instance for `Xcode 5.1`; used to check for the
    # availability of features and paths to various items on the filesystem.
    #
    # @return [RunLoop::Version] 5.1
    def v51
      RunLoop.deprecated('1.5.0', 'Replaced with RunLoop::Xcode') if RunLoop::Environment.debug?
      xcode.v51
    end

    # @deprecated Since 1.5.0 - replaced with RunLoop::Xcode
    # Returns a version instance for `Xcode 5.0`; used to check for the
    # availability of features and paths to various items on the filesystem.
    #
    # @return [RunLoop::Version] 5.0
    def v50
      RunLoop.deprecated('1.5.0', 'Replaced with RunLoop::Xcode') if RunLoop::Environment.debug?
      xcode.v50
    end

    # @deprecated Since 1.5.0 - replaced with RunLoop::Xcode
    # Are we running Xcode 6.4 or above?
    #
    # @return [Boolean] `true` if the current Xcode version is >= 6.4
    def xcode_version_gte_64?
      RunLoop.deprecated('1.5.0', 'Replaced with RunLoop::Xcode') if RunLoop::Environment.debug?
      xcode.version_gte_64?
    end

    # @deprecated Since 1.5.0 - replaced with RunLoop::Xcode
    # Are we running Xcode 6.3 or above?
    #
    # @return [Boolean] `true` if the current Xcode version is >= 6.3
    def xcode_version_gte_63?
      RunLoop.deprecated('1.5.0', 'Replaced with RunLoop::Xcode') if RunLoop::Environment.debug?
      xcode.version_gte_63?
    end

    # @deprecated Since 1.5.0 - replaced with RunLoop::Xcode
    # Are we running Xcode 6.2 or above?
    #
    # @return [Boolean] `true` if the current Xcode version is >= 6.2
    def xcode_version_gte_62?
      RunLoop.deprecated('1.5.0', 'Replaced with RunLoop::Xcode') if RunLoop::Environment.debug?
      xcode.version_gte_62?
    end

    # @deprecated Since 1.5.0 - replaced with RunLoop::Xcode
    # Are we running Xcode 6.1 or above?
    #
    # @return [Boolean] `true` if the current Xcode version is >= 6.1
    def xcode_version_gte_61?
      RunLoop.deprecated('1.5.0', 'Replaced with RunLoop::Xcode') if RunLoop::Environment.debug?
      xcode.version_gte_61?
    end

    # @deprecated Since 1.5.0 - replaced with RunLoop::Xcode
    # Are we running Xcode 6 or above?
    #
    # @return [Boolean] `true` if the current Xcode version is >= 6.0
    def xcode_version_gte_6?
      RunLoop.deprecated('1.5.0', 'Replaced with RunLoop::Xcode') if RunLoop::Environment.debug?
      xcode.version_gte_6?
    end

    # @deprecated Since 1.5.0 - replaced with RunLoop::Xcode
    # Are we running Xcode 7.1 or above?
    #
    # @return [Boolean] `true` if the current Xcode version is >= 7.1
    def xcode_version_gte_71?
      RunLoop.deprecated('1.5.0', 'Replaced with RunLoop::Xcode') if RunLoop::Environment.debug?
      xcode.version_gte_71?
    end

    # @deprecated Since 1.5.0 - replaced with RunLoop::Xcode
    # Are we running Xcode 7 or above?
    #
    # @return [Boolean] `true` if the current Xcode version is >= 7.0
    def xcode_version_gte_7?
      RunLoop.deprecated('1.5.0', 'Replaced with RunLoop::Xcode') if RunLoop::Environment.debug?
      xcode.version_gte_7?
    end

    # @deprecated Since 1.5.0 - replaced with RunLoop::Xcode
    # Are we running Xcode 5.1 or above?
    #
    # @return [Boolean] `true` if the current Xcode version is >= 5.1
    def xcode_version_gte_51?
      RunLoop.deprecated('1.5.0', 'Replaced with RunLoop::Xcode') if RunLoop::Environment.debug?
      xcode.version_gte_51?
    end

    # @deprecated Since 1.5.0 - replaced with RunLoop::Xcode
    # Returns the current version of Xcode.
    #
    # @return [RunLoop::Version] The current version of Xcode as reported by
    #  `xcrun xcodebuild -version`.
    def xcode_version
      RunLoop.deprecated('1.5.0', 'Replaced with RunLoop::Xcode') if RunLoop::Environment.debug?
      xcode.version
    end

    # @deprecated Since 1.5.0 - replaced with RunLoop::Xcode
    # Returns the path to the current developer directory.
    #
    # From the man pages:
    #
    # ```
    # $ man xcode-select
    # DEVELOPER_DIR
    # Overrides the active developer directory. When DEVELOPER_DIR is set,
    # its value will be used instead of the system-wide active developer
    # directory.
    #```
    #
    # @return [String] path to current developer directory
    def xcode_developer_dir
      RunLoop.deprecated('1.5.0', 'Replaced with RunLoop::Xcode') if RunLoop::Environment.debug?
      xcode.developer_dir
    end

    # @deprecated Since 1.5.0 - replaced with RunLoop::Xcode
    # Is this a beta version of Xcode?
    #
    # @note Relies on Xcode beta versions having and app bundle named Xcode-Beta.app
    # @return [Boolean] True if the Xcode version is beta.
    def xcode_is_beta?
      RunLoop.deprecated('1.5.0', 'Replaced with RunLoop::Xcode') if RunLoop::Environment.debug?
      xcode.beta?
    end

    alias_method :version_gte_64?, :xcode_version_gte_64?
    alias_method :version_gte_63?, :xcode_version_gte_63?
    alias_method :version_gte_62?, :xcode_version_gte_62?
    alias_method :version_gte_61?, :xcode_version_gte_61?
    alias_method :version_gte_6?, :xcode_version_gte_6?
    alias_method :version_gte_7?, :xcode_version_gte_7?
    alias_method :version_gte_51?, :xcode_version_gte_51?
    alias_method :version, :xcode_version
    alias_method :developer_dir, :xcode_developer_dir
    alias_method :beta?, :xcode_is_beta?

    # @deprecated Since 1.5.0 - replaced with RunLoop::Instruments.
    #
    # @see {RunLoop::Instruments#version}
    # @see {RunLoop::Instruments#templates}
    # @see {RunLoop::Instruments#physical_devices}
    # @see {RunLoop::Instruments#simulators}
    #
    # Method for interacting with instruments.
    #
    # @example Getting a runnable command for instruments
    #  instruments #=> 'xcrun instruments'
    #
    # @example Getting a the version of instruments.
    #  instruments(:version) #=> 5.1.1 - a Version object
    #
    # @example Getting list of known simulators.
    #  instruments(:sims) #=> < list of known simulators >
    #
    # @example Getting list of physical devices.
    #  instruments(:devices) #> < list of physical devices >
    #
    # @param [Version] cmd controls the return value.  currently accepts `nil`,
    #   `:sims`, `:templates`, and `:version` as valid parameters
    # @return [String,Array,Version] based on the value of `cmd` version, a list known
    #   simulators, the version of current instruments tool, or the path to the
    #   instruments binary.
    # @raise [ArgumentError] if invalid `cmd` is passed
    def instruments(cmd=nil)
      RunLoop.deprecated('1.5.0', 'Replaced with RunLoop::Instruments') if RunLoop::Environment.debug?
      instruments = 'xcrun instruments'
      return instruments if cmd == nil

      case cmd
        when :version
          instruments_instance.version
        when :sims
          instruments_instance.simulators
        when :templates
          instruments_instance.templates
        when :devices
          instruments_instance.physical_devices
        else
          candidates = [:version, :sims, :devices]
          raise(ArgumentError, "expected '#{cmd}' to be one of '#{candidates}'")
      end
    end

    # @deprecated Since 1.5.0 - no replacement.
    #
    # All supported Xcode versions accept -s flag.
    #
    # Does the instruments `version` accept the -s flag?
    #
    # @example
    #  instruments_supports_hyphen_s?('4.6.3') => false
    #  instruments_supports_hyphen_s?('5.0.2') => true
    #  instruments_supports_hyphen_s?('5.1')   => true
    #
    # @param [String, Version] version (instruments(:version))
    #   a major.minor[.patch] version string or a Version object
    #
    # @return [Boolean] true if the version is >= 5.*
    def instruments_supports_hyphen_s?(version=instruments(:version))
      RunLoop.deprecated('1.5.0', 'Not replaced.') if RunLoop::Environment.debug?
      @instruments_supports_hyphen_s ||= lambda {
        if version.is_a? String
          _version = RunLoop::Version.new(version)
        else
          _version = version
        end
        _version >= RunLoop::Version.new('5.1')
      }.call
    end

    private

    # @!visibility private
    attr_reader :xcode

    # @!visibility private
    def xcode
      @xcode ||= RunLoop::Xcode.new
    end

    # @!visibility private
    attr_reader :instruments_instance

    # @!visibility private
    def instruments_instance
      @instruments_instance ||= RunLoop::Instruments.new
    end
  end
end
