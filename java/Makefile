# Generated Java sorts: `make test` compiles and runs the test driver (JDK 17+).
OUT=out

test:
	mkdir -p $(OUT)
	javac -d $(OUT) src/sorting/*.java
	java -cp $(OUT) sorting.Tests

clean:
	rm -rf $(OUT)

.PHONY: test clean
