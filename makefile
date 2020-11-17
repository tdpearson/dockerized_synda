.PHONY: run stop copy_configs install_selection

#Per https://github.com/Prodiguer/synda/issues/106
SDDAO_PATCH=https://gist.githubusercontent.com/AtefBN/d2f55c26f5958a5be7653e81ef630ea3/raw/bd3111e6745e66cfb0568736a1cbb477d59cbd81/sddao.py

CONTAINER_SELECTION_PATH=/root/sdt/selection

#.EXPORT_ALL_VARIABLES:
#UID=$(shell id -u)
#GID=$(shell id -g)

build:
	@docker-compose build

copy_configs:
	@docker run --name synda_copy synda
	@docker cp synda_copy:/root/sdt .
	@docker rm synda_copy
	@docker-compose run --rm synda wget $(SDDAO_PATCH) -O /root/sdt/lib/sd/sddao.py
	@ln -s ./sdt/selection selection
	@ln -s ./sdt/data data
	@ln -s ./sdt/conf conf
	@ln -s ./sdt/db db
	@ln -s ./sdt/log log

run:
	@docker-compose up -d

stop:
	@docker-compose down

clean:
	@rm -rf sdt/
	@rm selection
	@rm data
	@rm conf
	@rm db
	@rm log

selection ?= "/sample/sample_selection_01.txt"
install_selection:
	@docker-compose run --rm synda synda install -s $(CONTAINER_SELECTION_PATH)$(selection)
