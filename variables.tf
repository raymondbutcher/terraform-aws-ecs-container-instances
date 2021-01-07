variable "alarms" {
  description = "Configures a CloudWatch alarm for when disks are full."
  type = object({
    disk_used_percent = object({
      threshold                 = number
      period                    = number
      evaluation_periods        = number
      datapoints_to_alarm       = number
      treat_missing_data        = string
      alarm_actions             = list(string)
      ok_actions                = list(string)
      insufficient_data_actions = list(string)
    })
  })
  default = null
}

variable "ami_pipeline" {
  description = "Enable this to use AMI deployments in conjunction with the pipeline module."
  type        = bool
  default     = false
}

variable "asg_name" {
  description = "The name to use when creating the auto scaling group. Defaults to the cluster name."
  type        = string
  default     = null
}

variable "boot_timeout_seconds" {
  description = "The time allowed for instances to boot before giving up."
  type        = number
  # Allow 15 minutes. It normally takes 2 minutes to launch and run the boot script.
  default = 60 * 15
}

variable "cloudwatch_agent" {
  description = "Run CloudWatch Agent as a daemon service."
  type        = bool
  default     = false
}

variable "cluster_name" {
  type = string
}

variable "drain_timeout_seconds" {
  description = "The time allowed for instances to be drained before giving up."
  type        = number
  # Allow 1 hour. It normally takes several minutes to drain tasks when terminating.
  # CloudFormation custom resources, which are used for draining, have a 1 hour limit
  # so 1 hour is the maximum we can use here. We could use a more complicated
  # CloudFormation wait condition if this limit is a problem.
  default = 60 * 60
}

variable "image_id" {
  description = "AMI to use if the AMI pipeline is disabled."
  type        = string
  default     = ""
}

variable "instance_types" {
  description = "The instance types to use and their weights. Set weight to 1 if there is only one instance type. See https://docs.aws.amazon.com/autoscaling/ec2/userguide/asg-instance-weighting.html"
  type        = list(object({
    type   = string
    weight = number
  }))
}

variable "max_size" {
  type = number
}

variable "pipeline_auto_deploy" {
  type    = bool
  default = null
}

variable "pipeline_aws_account_id" {
  type    = string
  default = null
}

variable "pipeline_target_name" {
  type    = string
  default = null
}

variable "spot_instances_policy" {
  description = "Customise spot instances behaviour by setting any of OnDemandAllocationStrategy, OnDemandBaseCapacity, OnDemandPercentageAboveBaseCapacity, SpotAllocationStrategy, SpotInstancePools, SpotMaxPrice from https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-properties-autoscaling-autoscalinggroup-instancesdistribution.html"
  type        = map(string)
  default     = {}
}

variable "subnet_ids" {
  type = list(string)
}

variable "tags" {
  type    = map(string)
  default = {}
}

variable "user_data" {
  type    = string
  default = ""
}

variable "vpc_id" {
  type = string
}
