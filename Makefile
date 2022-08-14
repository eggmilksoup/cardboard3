all: bin/mention     \
     bin/logmentions \
     bin/msg

bin/logmentions: src/logmentions.go
	cd bin && go build ../src/logmentions.go

bin/mention: src/mention.go
	cd bin && go build ../src/mention.go

bin/msg: src/msg.go
	cd bin && go build ../src/msg.go
