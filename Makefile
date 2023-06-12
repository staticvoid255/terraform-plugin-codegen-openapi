lint:
	golangci-lint run

fmt:
	gofmt -s -w -e .

test:
	go test $$(go list ./... | grep -v /output) -v -cover -timeout=120s -parallel=4

# Generate copywrite headers
generate:
	cd tools; go generate ./...

# Regenerate testdata folder
testdata:
	go run ./cmd/terraform-plugin-codegen-openapi generate \
		--config ./internal/cmd/testdata/petstore3/tfopenapigen_config.yml \
		--output ./internal/cmd/testdata/petstore3/generated_framework_ir.json \
		./internal/cmd/testdata/petstore3/openapi_spec.json

	go run ./cmd/terraform-plugin-codegen-openapi generate \
		--config ./internal/cmd/testdata/github/tfopenapigen_config.yml \
		--output ./internal/cmd/testdata/github/generated_framework_ir.json \
		./internal/cmd/testdata/github/openapi_spec.json

	go run ./cmd/terraform-plugin-codegen-openapi generate \
		--config ./internal/cmd/testdata/scaleway/tfopenapigen_config.yml \
		--output ./internal/cmd/testdata/scaleway/generated_framework_ir.json \
		./internal/cmd/testdata/scaleway/openapi_spec.yml

.PHONY: lint fmt test