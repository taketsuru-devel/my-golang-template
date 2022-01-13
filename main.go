package main

import (
	"my-golang-template/internal/logger"
)

func main() {
	logger.SetDefaultLogger()
	logger.Debug("hello world")
}
