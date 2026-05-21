-include .env
export

PROJECT_NAME := MovieBrowser
XCCONFIG_DIR := Source/$(PROJECT_NAME)/Supporting/Configs
DEV_TMDB_KEY := $(shell echo | openssl s_client -servername developer.themoviedb.org -connect developer.themoviedb.org:443 2>/dev/null | openssl x509 -pubkey -noout | openssl pkey -pubin -outform der | openssl dgst -sha256 -binary | openssl enc -base64)
API_TMDB_KEY := $(shell echo | openssl s_client -servername api.themoviedb.org -connect api.themoviedb.org:443 2>/dev/null | openssl x509 -pubkey -noout | openssl pkey -pubin -outform der | openssl dgst -sha256 -binary | openssl enc -base64)
DEBUG_CONFIG := $(XCCONFIG_DIR)/Debug.xcconfig
RELEASE_CONFIG := $(XCCONFIG_DIR)/Release.xcconfig

.PHONY: install clean setup generate open start reset

install:
	@echo "🔧 Ferramentas necessárias..."
	@command -v brew >/dev/null 2>&1 || { echo "❌ Homebrew is not installed. Please install it first."; exit 1; }
	brew install swiftlint swiftformat xcodegen
	@echo "✅ Ferramentas instaladas."

clean:
	@echo "🧹 Limpando o projeto..."
	@rm -rf Source/*.xcodeproj
	@rm -rf DerivedData
	@find . -type d -name build -exec rm -rf {} +
	@find . -type d -name .build -exec rm -rf {} +
	@find . -type d -name .swiftpm -exec rm -rf {} +
	@echo "🗑️  Limpeza concluída."

setup: install clean
	@echo "🔧 Configurando o projeto..."
	@echo "✅ Projeto configurado."

generate:
	@echo "🔐 Injetando chaves e gerando o projeto com XcodeGen..."
	@mkdir -p $(XCCONFIG_DIR)
	@echo "TMDB_SSL_PINNING_KEY = $(DEV_TMDB_KEY)" > $(DEBUG_CONFIG)
	@echo "TMDB_SSL_PINNING_KEY = $(API_TMDB_KEY)" > $(RELEASE_CONFIG)
	@echo "API_TOKEN = $(API_TOKEN)" >> $(DEBUG_CONFIG)
	@echo "API_TOKEN = $(API_TOKEN)" >> $(RELEASE_CONFIG)
	@echo "API_KEY = $(API_KEY)" >> $(DEBUG_CONFIG)
	@echo "API_KEY = $(API_KEY)" >> $(RELEASE_CONFIG)
	@echo "✅ chaves injetadas."
	@echo "🔧 Gerando o projeto Xcode..."
	@xcodegen generate --project Source/
	@echo "✅ Projeto Xcode gerado."

open:
	@echo "📂 Abrindo o projeto no Xcode..."
	@open -a Xcode Source/$(PROJECT_NAME).xcodeproj

start: setup generate open
	@echo "🚀 Projeto pronto para desenvolvimento!"

reset: clean start
	@echo "🔄 Projeto resetado e pronto para desenvolvimento!"