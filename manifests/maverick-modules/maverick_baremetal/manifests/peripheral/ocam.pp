class maverick_baremetal::peripheral::ocam (
) {
    
    # Add ocam software from git
    ensure_packages(["qt4-default", "libv4l-dev", "libudev-dev"])
    oncevcsrepo { "git-odroid-ocam":
        gitsource   => "https://github.com/withrobot/oCam.git",
        dest        => "/srv/maverick/software/odroid-ocam",
    }
    exec { "ocam-viewer-compile":
        user        => "mav",
        timeout     => 0,
        command     => "/usr/bin/qmake && /usr/bin/make -j${::processorcount} release >/srv/maverick/data/logs/build/ocam-viewer.build.log 2>&1",
        cwd         => "/srv/maverick/software/odroid-ocam/oCam_viewer",
        creates     => "/srv/maverick/software/odroid-ocam/oCam_viewer/oCam-viewer",
    } ->
    file { "/srv/maverick/software/maverick/bin/ocam-viewer":
        ensure      => link,
        target      => "/srv/maverick/software/odroid-ocam/oCam_viewer/oCam-viewer",
    }
    
}