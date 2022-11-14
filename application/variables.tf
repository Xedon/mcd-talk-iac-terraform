variable "dynamodb_table_prefix" {
  default = "GameScores"
}
variable "restore_date_time" {
  description = "DynamoDb restore time"
  default     = null
}
