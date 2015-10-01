#!/usr/bin/perl
use strict;
use warnings;

my $studentPattern = qr/([^:]*):(([^:]*):([^:]*))/;

# nameString getName(aStudentString)
# looking for pattern name:class:grade
# assumes legal student pattern
sub getName{
	my $aStudentString = shift;
	if($aStudentString =~ $studentPattern){
		return $1;
	}
	return "";
}

# classAndGradeString getClassAndGrade(aStudentString)
# looking for pattern name:class:grade
# assumes legal student pattern
sub getClassAndGrade{
	my $aStudentString = shift;
	if($aStudentString =~ $studentPattern){
		return $2;
	}
	return "";
}

# hashTableRef getGradeSheet(studentStrings[])
sub getGradeSheet{
    my @studentStrings = @_;
    my %gradeSheet = ();
    foreach(@studentStrings){
        my $studentName = getName($_);
        # see if student is already in the table...
        # if first time - Put a new array ref with class and grade at student name
        # else          - Add class and grade to array ref (ie. Push)
        if(exists $gradeSheet{$studentName}){
            push $gradeSheet{$studentName}, getClassAndGrade($_);
        } else {
            my @courseInfo = (getClassAndGrade($_));
            $gradeSheet{$studentName} = \@courseInfo;
        }
    }
    return \%gradeSheet;
}

1;
