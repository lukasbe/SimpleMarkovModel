(
~chordBaseTemplate = (
	name: "",
	numTransitions: 0,
	followingChords: Array.new,
	probabilities: Array.new,
	addFollowingChord: {|self, entry|
		var containsIndex = -1;
		self.numTransitions = self.numTransitions + 1;
		//iterate over array to see if entry is already there
		//save index if so
		self.followingChords.do{|item, index|
			if(item.key == entry) {containsIndex = index};
		};
		//if not there add new Entry with occurrence of 1
		if(containsIndex == -1)
		{
			self.followingChords = self.followingChords.add(entry -> 1);
		}
		//else increment occurrences by 1
		{
			var occ = self.followingChords.at(containsIndex).value;
			self.followingChords.put(containsIndex, entry -> (occ+1));
		};
		self.calcProbabilities;
	},
	calcProbabilities:{|self|
		self.probabilities = Array.newClear(self.followingChords.size);
		self.followingChords.do{|item, index|
			self.probabilities.put(index, item.key -> (item.value/self.numTransitions));
		}
	},
	print: {|self|
				(self.name + ":").postln;
		"".postln;
		self.followingChords.postln;
		self.probabilities.postln;
		"".postln;
	}
);

~chordList = ["Cm","D#","F","D#","Gm","Bb","A#sus5","A7sus4","Gm","Bb","A#sus5","A7sus4","Gm","Bb","A#sus5","A7sus4","Cm","D#","F","D#","Gm","Bb","A#sus5","A7sus4","Gm","Bb","A#sus5","A7sus4","Cm","D#","F","D#","Gm","Bb","A#sus5","A7sus4","Gm","Bb","A#sus5","A7sus4","Gm","Dm*","E","Gm","Gm","Dm*","E","Gm","Dm*","E","Gm","Gm","Dm*","E","Am","G#","C","D","Am","G#","C", "D"];

~chords = (
	list: Array.new,
	find:{|self, entry|
		var index = -1;
		self.list.do{|n, i|
			if(entry == n.name){index = i;};
		};
		self.list.at(index);
	}
);
for(0, (~chordList.size - 1), {|i|
	var o = -1;
	~chords.list.do{|n, j|
		if(n.name == ~chordList.at(i)){o = j;}
	};
	if(o != -1){
		//update if chord already exists in list.
		if(~chordList.at(i+1).isNil == false){
			//check for last chord and avoid index overflow
			~chords.list.at(o).addFollowingChord(~chordList.at(i+1));
		}
	}
	{
		//add to list if chord doesn't exist
		var tmp = ~chordBaseTemplate.deepCopy;
		tmp.name = ~chordList.at(i);
		if(~chordList.at(i+1).isNil == false){
			//check for last chord and avoid index overflow
			tmp.addFollowingChord(~chordList.at(i+1));
		};
		~chords.list = ~chords.list.add(tmp);
	}
});



//~chords.list.do{|n,i|
//	n.print;
//};

//init with first entry
~test = ~chords.find(~chordList.at(0));
~test.name.postln;
(0..40).do{
	var names = Array.new;
	var probabilities = Array.new;
	~test.probabilities.do{|n, i|
		names = names.add(n.key);
		probabilities = probabilities.add(n.value);
	};
	c = names.wchoose(probabilities);
	c.postln;
	~test = ~chords.find(c);
}

)

//chordBaseTemplate.followingChords.at(0).key.postln;