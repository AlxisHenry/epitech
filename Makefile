.PHONE: clean
clean:
	@find ./* -type f -name "*.Identifier" -exec rm -f {} \;

teams:
	bash ./teams.sh
