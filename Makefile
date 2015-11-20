ARCH = $(shell dpkg-architecture -qDEB_BUILD_MULTIARCH)
CXXFLAGS = -std=c++11
EXECUTABLE = agent
LDFLAGS = -Wl,-rpath /usr/local/lib/$(ARCH) -Llibical/build/lib
LDLIBS = -lical -licalss -licalvcal -lical_cxx -licalss_cxx
SRCS = main.cpp Entity.cpp Agent.cpp TimeSlotFinder.cpp networking.cpp
OBJS = $(SRCS:.cpp=.o)

.PHONY: depend clean extreme

all: $(EXECUTABLE)

$(EXECUTABLE): $(OBJS)
	$(CXX) $(CXXFLAGS) -o $(EXECUTABLE) $(OBJS) $(LDFLAGS) $(LDLIBS)

.cpp.o:
	$(CXX) $(CXXFLAGS) -c $< -o $@

clean:
	$(RM) *.o $(EXECUTABLE)

depend: $(SRCS)
	makedepend $(INCLUDES) $^

extreme: CXXFLAGS += -Wall -Wextra -Werror -pedantic-errors
extreme: all

# Aren't *you* curious? You too can have your dependencies auto-generated!
# 1. Install makedepend (`sudo apt-get install xutils-dev`)
# 2. Run `make depend` when you add new header files
# 3. Tweak the generated dependencies as necessary

# DO NOT DELETE

main.o: Agent.h Entity.h TimeSlotFinder.h
Entity.o: Entity.h
Agent.o: Agent.h Entity.h
TimeSlotFinder.o: TimeSlotFinder.h Entity.h
