{
  disko.devices = {
    disk = {
      root = {
        type = "disk";
        device = "/dev/nvme0n1";
        content = {
          type = "gpt";
          partitions = {
            ESP = {
              size = "1G";
              type = "EF00";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
                mountOptions = [ "nofail" ];
              };
            };
            zfs = {
              size = "100%";
              content = {
                type = "zfs";
                pool = "zroot";
              };
            };
          };
        };
      };
    };
    zpool = {
      zroot = {
        type = "zpool";
        rootFsOptions = {
          mountpoint = "none";
          compression = "zstd";
          acltype = "posixacl";
          xattr = "sa";
          "com.sun:auto-snapshot" = "true";
        };
        options.ashift = "12";
        datasets = {
          "root" = {
            type = "zfs_fs";
            options = {
              "com.sun:auto-snapshot" = "true";
              # encryption = "aes-256-gcm";
              # keyformat = "passphrase";
              # keylocation = "prompt";
            };
            mountpoint = "/";

          };
          "root/nix" = {
            type = "zfs_fs";
            options = {
              mountpoint = "/nix";
              "com.sun:auto-snapshot" = "false";
            };
            mountpoint = "/nix";
          };
          "root/home" = {
            type = "zfs_fs";
            options = {
              mountpoint = "/home";
            };
            mountpoint = "/home";
          };
        };
      };
    };
  };
}
