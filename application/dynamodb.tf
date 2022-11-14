resource "random_pet" "table_pet" {
  prefix = terraform.workspace
}

resource "aws_dynamodb_table" "GameScores" {
  name         = "${random_pet.table_pet.id}-${var.dynamodb_table_prefix}"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "UserId"
  range_key    = "GameTitle"

  restore_date_time = var.restore_date_time
  point_in_time_recovery {
    enabled = true
  }

  attribute {
    name = "UserId"
    type = "S"
  }

  attribute {
    name = "GameTitle"
    type = "S"
  }
}

resource "aws_dynamodb_table_item" "testdata" {
  table_name = aws_dynamodb_table.GameScores.name
  hash_key   = aws_dynamodb_table.GameScores.hash_key
  range_key  = aws_dynamodb_table.GameScores.range_key

  count = terraform.workspace == "test" ? 1 : 0

  item = file("testdata.json")
}
