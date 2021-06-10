SWJAR="swagger-codegen-cli-2.2.1.jar"
FILES:=$(shell ls api)
APPLICATIONJAR="app-0610-java-2"

.PHONY: install
install:
	@if [ ! -e ${SWJAR} ]; then \
		wget https://oss.sonatype.org/content/repositories/releases/io/swagger/swagger-codegen-cli/2.2.1/${SWJAR}; \
	fi


.PHONY: sw
sw: install
	@for file in ${FILES}; do \
		java -jar swagger-codegen-cli-2.2.1.jar generate -i api/$${file} -c config.json -l spring; \
		echo "----------------------------------------------------------------------------------"; \
		echo ""; \
	done


.PHONY: package
package: sw
	@mvn clean install
	@mvn package


.PHONY: start
start: package
	@GENJAR=`ls target | grep -E ${APPLICATIONJAR}.*\.jar$$` && java -jar target/$${GENJAR}
