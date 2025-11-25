output "mq_broker_id" {
  value = aws_mq_broker.mq_broker.id
}

output "mq_broker_endpoint" {
  value = aws_mq_broker.mq_broker.instances[0].endpoints[0]
}
