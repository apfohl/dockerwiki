IMAGE=apfohl/dockerwiki:development
CONTAINER=dockerwiki

RUNARGS = \
	-d \
	--name=$(CONTAINER) \
	-h $(CONTAINER) \
	-p 8080:80 \
	-e TZ="Europe/Berlin"

.PHONY: build run shell rm logs

build:
	@docker build -t $(IMAGE) .

run:
	@docker run $(RUNARGS) $(IMAGE)

shell:
	@docker exec -it $(CONTAINER) sh

rm:
	@docker rm -f $(CONTAINER)

logs:
	@docker logs $(CONTAINER)
