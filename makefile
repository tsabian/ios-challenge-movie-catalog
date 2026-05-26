-include .env
-include .env.Debug

PROJECT_NAME := MovieBrowser
XCCONFIG_DIR := Source/$(PROJECT_NAME)/Supporting/Configs
IMG_TMDB_KEY := $(shell echo | openssl s_client -servername image.tmdb.org -connect image.tmdb.org:443 2>/dev/null | openssl x509 -pubkey -noout | openssl pkey -pubin -outform der | openssl dgst -sha256 -binary | openssl enc -base64)
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
	@echo "🔧 Gerando arquivos de configuração..."
	@mkdir -p $(XCCONFIG_DIR)
	@cat .env.Debug > $(DEBUG_CONFIG)
	@cat .env > $(RELEASE_CONFIG)
	@echo "" >> $(DEBUG_CONFIG)
	@echo "" >> $(RELEASE_CONFIG)
	@echo "✅ Configurações geradas."
	@echo "🔐 Injetando chaves e gerando o projeto com XcodeGen..."
	@echo "TMDB_IMG_SSL_PINNING_KEY = $(IMG_TMDB_KEY)" >> $(DEBUG_CONFIG)
	@echo "TMDB_API_SSL_PINNING_KEY = $(API_TMDB_KEY)" >> $(DEBUG_CONFIG)
	@echo "TMDB_IMG_SSL_PINNING_KEY = $(IMG_TMDB_KEY)" >> $(RELEASE_CONFIG)
	@echo "TMDB_API_SSL_PINNING_KEY = $(API_TMDB_KEY)" >> $(RELEASE_CONFIG)
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