# If looking up a cluster profile instead of creating a new one
# data "spectrocloud_cluster_profile" "profile" {
#   # id = <uid>
#   name = var.cluster_profile_name
# }

# # Example of a Basic add-on profile
# resource "spectrocloud_cluster_profile" "cp-addon-aws" {
#   name        = var.cluster_profile_name
#   description = var.cluster_profile_description
#   cloud       = var.cloud
#   type        = var.type
#   pack {
#     name = "spectro-byo-manifest"
#     tag  = "1.0.x"
#     uid  = "5faad584f244cfe0b98cf489"
#     # layer  = ""
#     values = <<-EOT
#       manifests:
#         byo-manifest:
#           contents: |
#             # Add manifests here
#             apiVersion: v1
#             kind: Namespace
#             metadata:
#               labels:
#                 app: wordpress
#                 app3: wordpress3
#               name: wordpress
#     EOT
#   }
# }

data "spectrocloud_registry" "registry" {
  name = "Public Repo"
}

data "spectrocloud_pack" "prismacloud" {
  name = "prismacloud"
  registry_uid = data.spectrocloud_registry.registry.id
  version  = "20.09.0"
}

data "spectrocloud_pack" "sapp-hipster" {
  name = "sapp-hipster"
  registry_uid = data.spectrocloud_registry.registry.id
  version  = "3.0.0"
}

data "spectrocloud_pack" "nginx" {
  name = "nginx"
  registry_uid = data.spectrocloud_registry.registry.id
  version  = "1.0.4"
}

data "spectrocloud_pack" "argo" {
  name = "argo-cd"
  registry_uid = data.spectrocloud_registry.registry.id
  version  = "3.26.7"
}

data "spectrocloud_pack" "k8sdash" {
  name = "k8s-dashboard"
  registry_uid = data.spectrocloud_registry.registry.id
  version  = "2.4.0"
}


data "spectrocloud_pack" "csi" {
  name = "csi-aws"
  registry_uid = data.spectrocloud_registry.registry.id
  version  = "1.0.0"
}

data "spectrocloud_pack" "cni" {
  name    = "cni-calico"
  registry_uid = data.spectrocloud_registry.registry.id
  version = "3.22.0"
}

data "spectrocloud_pack" "k8s" {
  name    = "kubernetes"
  registry_uid = data.spectrocloud_registry.registry.id
  version = "1.23.4"
}

data "spectrocloud_pack" "ubuntu" {
  name = "ubuntu-aws"
  registry_uid = data.spectrocloud_registry.registry.id
  version  = "20.04"
}


resource "spectrocloud_cluster_profile" "profile" {
  name        = var.sc_cp_profile_name
  description = var.sc_cp_profile_description
  tags        = var.sc_cp_profile_tags
  cloud       = var.sc_cp_cloud
  type        = var.sc_cp_type
  version     = var.sc_cp_version

pack {
    name   = "ubuntu-aws"
    tag    = data.spectrocloud_pack.ubuntu.version
    uid    = data.spectrocloud_pack.ubuntu.id
    values = data.spectrocloud_pack.ubuntu.values
  }

pack {
    name   = "kubernetes"
    tag    = data.spectrocloud_pack.k8s.version
    uid    = data.spectrocloud_pack.k8s.id
    values = data.spectrocloud_pack.k8s.values
  }

pack {
    name   = "cni-calico"
    tag    = data.spectrocloud_pack.cni.version
    uid    = data.spectrocloud_pack.cni.id
    values = data.spectrocloud_pack.cni.values
  }

pack {
    name   = "csi-aws"
    tag    = data.spectrocloud_pack.csi.version
    uid    = data.spectrocloud_pack.csi.id
    values = data.spectrocloud_pack.csi.values
  }

pack {
    name   = "prismacloud"
    tag    = data.spectrocloud_pack.prismacloud.version
    uid    = data.spectrocloud_pack.prismacloud.id
    values = <<-EOT
manifests:
  prisma-cloud:

    # The namespace used to deploy prisma-cloud resources
    namespace: twistlock

    # Service type for Prisma Cloud Console; Supported values are ClusterIP, NodePort, and LoadBalancer
    consoleSvcType: LoadBalancer

    # The max timeout (in seconds) to wait for the Console service to be ready
    consoleSvcTimeout: 600s

    # Prisma Cloud Console service User. When left empty, admin will be the Username
    consoleUser: ""

    # Prisma Cloud Console service Password. When left empty, welcome123 will be the Password
    consolePassword: ""

    # When provided, Defender will connect to this Console address. Example: https://127.0.0.1:8083
    externalConsoleAddr: ""

    # Address that Defenders use to communicate with Prisma Cloud Console. Example: prismacloud-console.company.com
    clusterAddr: ""

    # Access token to use for downloading Console / Defender images
    accessToken: "wgdhemeo0dlxlflyhtmeob8uo4t1ffky"

    # The license key to use for Prisma Cloud Console (self-hosted)
    licenseKey: "VuzwEtAVKvPnyK5OdDo5MtK0iBucs85yFninE4W9uro4OtjjwfRMxzsbp8VbvzhTBooZYMIooYkoPdw4kqvuKEc/e7Smfaquz31k50vRuBq1/CP7VZPMIyLpp0CTKYK5p5X0tSZdmpz+fzK2wtrlYYZZqEpeesiPM06Hc8Y3imkOGICWUAnZA93aoNw61FMYE7lR1anI4+b0LT9bnBI88USya1VAoiyc2y5mgDPNUgKo+ziddQXvv7CJi++BvTRv/hs3poPA6SQwWPdX+E0vvlfoQ6cyRz/QR5jVlHC2trMkAbXD4+fhP+4ITS0ffxv2v0/xfAWbsHOWOY+/4rDE+cH5Kc4QdpZvDxEu7+bHZtyJrTLDsbxDuKtRSOtRwwo2iI29lqi3zbSGN4MXXJMEojesYlMd7e8tWBoKjot96IcZaO43r37QY+axkAVdBVHeMRa61N5PEkEhLXO3T24M1CAC24Rdd+a8uoTwtzxN2kR84HPtFnnzq52MCcCVTQ/HYvd427AUbs/I2C4LRbBrpXhyQ00hb8A6w5awRSw3Rx/Ljla7sz0VziIpmLiPhPx6OURp2VFADjLmBqiK1uOTqCCqE33utFkyVXGlDlrBKqJWuM5G+iIHGWiWUn0DL/9oGYNSiNGVZnlt8kdFnrPYR50rO7mGPXeEFKp6AVLYixo="

    # Prisma Cloud Compute Edition bits URL
    releaseUrl: https://cdn.twistlock.com/releases/f801n066/prisma_cloud_compute_edition_20_09_365.tar.gz

    # Prisma Cloud CA certificate file to use for Defender deployment
    # Copy paste the ca cert contents
    tlscacert: |-
    EOT
  }

pack {
    name   = "nginx"
    tag    = data.spectrocloud_pack.nginx.version
    uid    = data.spectrocloud_pack.nginx.id
    values = data.spectrocloud_pack.nginx.values
  }  
  
pack {
    name   = "k8s-dashboard"
    tag    = data.spectrocloud_pack.k8sdash.version
    uid    = data.spectrocloud_pack.k8sdash.id
    values = <<-EOT
manifests:
  k8s-dashboard:
    #Ingress config
    annotations: null
      # kubernetes.io/cluster-name: "cluster123"
      # kubernetes.io/version: "2.4.0"

      # Additional labels to be applied to Kubernetes Dashboard deployment, pod & service
    labels: null
      # app.kubernetes.io/name: "kubernetes-dashboard"
      # app.kubernetes.io/version: "2.4.0"

      #Namespace to install kubernetes-dashboard
    namespace: "kubernetes-dashboard"
    #The ClusterRole to assign for kubernetes-dashboard. By default, a ready-only cluster role is provisioned
    clusterRole: "k8s-dashboard-readonly"
    #Self-Signed Certificate duration in hours
    certDuration: 8760h #365d
    #Self-Signed Certificate renewal in hours
    certRenewal: 720h #30d
    #Flag to enable skip login option on the dashboard login page
    skipLogin: true
    #Ingress config
    ingress:
      #Ingress host
      enabled: false
      #  - secretName: k8s-dashboard-tls
      #    hosts:
      #      - kubernetes-dashboard.example.com
    serviceType: LoadBalancer
    EOT    
  } 

pack {
    name   = "argo-cd"
    tag    = data.spectrocloud_pack.argo.version
    uid    = data.spectrocloud_pack.argo.id
    values = data.spectrocloud_pack.argo.values
  }  

pack {
    name   = "sapp-hipster"
    tag    = data.spectrocloud_pack.sapp-hipster.version
    uid    = data.spectrocloud_pack.sapp-hipster.id
    values = data.spectrocloud_pack.sapp-hipster.values
  }  
  
}
