{ pkgs, config, ... }:
{
    home.packages = with pkgs;[
        # pipewire
        # pulseaudio
    ];

    home.file."pipewire" = {
            target = "./.config/pipewire/pipewire.conf";
            text =
''
# Daemon config file for PipeWire version "0.3.39" #
#
# Copy and edit this file in /etc/pipewire for system-wide changes
# or in ~/.config/pipewire for local changes.

context.properties = {
    ## Configure properties in the system.
    #library.name.system                   = support/libspa-support
    #context.data-loop.library.name.system = support/libspa-support
    #support.dbus                          = true
    #link.max-buffers                      = 64
    link.max-buffers                       = 16                       # version < 3 clients can't handle more
    #mem.warn-mlock                        = false
    #mem.allow-mlock                       = true
    #mem.mlock-all                         = false
    #clock.power-of-two-quantum            = true
    #log.level                             = 2
    #cpu.zero.denormals                    = true

    core.daemon = true              # listening for socket connections
    core.name   = pipewire-0        # core name and socket name

    ## Properties for the DSP configuration.
    #default.clock.rate          = 48000
    #default.clock.allowed-rates = [ 48000 ]

    #To not crash Carla
    default.clock.quantum       = 1024

    #default.clock.min-quantum   = 32
    #default.clock.max-quantum   = 8192
    # default.clock.min-quantum   = 1024
    # default.clock.max-quantum   = 1024
    #default.video.width         = 640
    #default.video.height        = 480
    #default.video.rate.num      = 25
    #default.video.rate.denom    = 1
    #
    # These overrides are only applied when running in a vm.
    # vm.overrides = {
    #     default.clock.min-quantum = 1024
    # }
}

context.spa-libs = {
    #<factory-name regex> = <library-name>
    #
    # Used to find spa factory names. It maps an spa factory name
    # regular expression to a library name that should contain
    # that factory.
    #
    audio.convert.* = audioconvert/libspa-audioconvert
    api.alsa.*      = alsa/libspa-alsa
    api.v4l2.*      = v4l2/libspa-v4l2
    api.libcamera.* = libcamera/libspa-libcamera
    api.bluez5.*    = bluez5/libspa-bluez5
    api.vulkan.*    = vulkan/libspa-vulkan
    api.jack.*      = jack/libspa-jack
    support.*       = support/libspa-support
    #videotestsrc   = videotestsrc/libspa-videotestsrc
    #audiotestsrc   = audiotestsrc/libspa-audiotestsrc
}

context.modules = [
    #{ name = <module-name>
    #    [ args  = { <key> = <value> ... } ]
    #    [ flags = [ [ ifexists ] [ nofail ] ]
    #}
    #
    # Loads a module with the given parameters.
    # If ifexists is given, the module is ignored when it is not found.
    # If nofail is given, module initialization failures are ignored.
    #

    # Uses RTKit to boost the data thread priority.
    { name = libpipewire-module-rtkit
        args = {
            #nice.level   = -11
            #rt.prio      = 88
            #rt.time.soft = 2000000
            #rt.time.hard = 2000000
        }
        flags = [ ifexists nofail ]
    }

    # Set thread priorities without using RTKit.
    #{ name = libpipewire-module-rt
    #    args = {
    #        nice.level   = -11
    #        rt.prio      = 88
    #        rt.time.soft = 2000000
    #        rt.time.hard = 2000000
    #    }
    #    flags = [ ifexists nofail ]
    #}

    # The native communication protocol.
    { name = libpipewire-module-protocol-native }

    # The profile module. Allows application to access profiler
    # and performance data. It provides an interface that is used
    # by pw-top and pw-profiler.
    { name = libpipewire-module-profiler }

    # Allows applications to create metadata objects. It creates
    # a factory for Metadata objects.
    { name = libpipewire-module-metadata }

    # Creates a factory for making devices that run in the
    # context of the PipeWire server.
    { name = libpipewire-module-spa-device-factory }

    # Creates a factory for making nodes that run in the
    # context of the PipeWire server.
    { name = libpipewire-module-spa-node-factory }

    # Allows creating nodes that run in the context of the
    # client. Is used by all clients that want to provide
    # data to PipeWire.
    { name = libpipewire-module-client-node }

    # Allows creating devices that run in the context of the
    # client. Is used by the session manager.
    { name = libpipewire-module-client-device }

    # The portal module monitors the PID of the portal process
    # and tags connections with the same PID as portal
    # connections.
    { name = libpipewire-module-portal
        flags = [ ifexists nofail ]
    }

    # The access module can perform access checks and block
    # new clients.
    { name = libpipewire-module-access
        args = {
            # access.allowed to list an array of paths of allowed
            # apps.
            #access.allowed = [
            #    /usr/bin/pipewire-media-session
            #]

            # An array of rejected paths.
            #access.rejected = [ ]

            # An array of paths with restricted access.
            #access.restricted = [ ]

            # Anything not in the above lists gets assigned the
            # access.force permission.
            #access.force = flatpak
        }
    }

    # Makes a factory for wrapping nodes in an adapter with a
    # converter and resampler.
    { name = libpipewire-module-adapter }

    # Makes a factory for creating links between ports.
    { name = libpipewire-module-link-factory }

    # Provides factories to make session manager objects.
    { name = libpipewire-module-session-manager }
]

context.objects = [
    { factory = spa-node-factory
        args = {
            factory.name    = support.node.driver
            node.name       = Dummy-Driver
            node.group      = pipewire.dummy
            priority.driver = 20000
        }
    }
    { factory = spa-node-factory
        args = {
            factory.name    = support.node.driver
            node.name       = Freewheel-Driver
            priority.driver = 19000
            node.group      = pipewire.freewheel
            node.freewheel  = true
        }
    }
]

context.exec = [
    #Main outputs
    { path = "${pkgs.pulseaudio}/bin/pactl" args = "load-module module-null-sink media.class=Audio/Source/Virtual sink_name=Main_Microphone"}
    { path = "${pkgs.pulseaudio}/bin/pactl" args = "load-module module-null-sink media.class=Audio/Sink sink_name=Main_Headphone"}
    
    #Seperate appllications
    { path = "${pkgs.pulseaudio}/bin/pactl" args = "load-module module-null-sink media.class=Audio/Sink sink_name=Discord"}
    { path = "${pkgs.pulseaudio}/bin/pactl" args = "load-module module-null-sink media.class=Audio/Sink sink_name=Browser"}
    { path = "${pkgs.pulseaudio}/bin/pactl" args = "load-module module-null-sink media.class=Audio/Sink sink_name=Music"}
    { path = "${pkgs.pulseaudio}/bin/pactl" args = "load-module module-null-sink media.class=Audio/Sink sink_name=VM"}
]
'';
    };
    
}