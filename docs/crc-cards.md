Card 1: Student

Class
Student

Responsibilities

-Check their current completion status.
-View a summary of credits completed to date.
-View any outstanding requirements still needed for their programme.
-Request and access their completion letter once eligible.
-Provide the necessary details to allow their academic record to be retrieved.

Collaborators
-Enrolment
-LetterRequest

Card 2: Enrolment

Class
Enrolment

Responsibilities
-Records that the student is enrolled in a particular programme
-Keeps track of the enrolment status and the start date
Stores the student's course results
-Passes those course results along when a completion check needs them

Collaborators
Student
Programme
CourseResult
CompletionCheck

Card 3: Completion Check

Class
Completion Check

Responsibilities
Checks the student's course results against what the programme actually requires
Works out (and double-checks) how many credits have been earned
Figures out whether all the mandatory requirements have been met
Flags any requirements that haven't been met yet
Records the outcome of the check
Records when the check was done


Collaborators
-Enrolmemt
-Programme
-CompletionRequirement
-LetterRequest


Card 4: LetterRequest

Class
LetterRequest

Responsibilities
Records that a student has requested a completion letter
Stores the purpose of the request and the date it was made
Kicks off a completion check
Keeps track of the status of the request
Takes in the approval decision once it's made
Generates the completion letter once approved


Collaborators
Student
CompletionCheck
ApprovalDecision
CompletionLetter
RegistryOfficer

Card 5: Programme

Class
Programme

Responsibilities:

Sets out the minimum number of credits needed to complete the programme
Sets out what's needed overall to complete the programme
Supplies these requirements so a student's progress can be checked against them

Collaborators:

Enrolment
CompletionRequirement
CompletionCheck

Card 6: CompletionRequirement

Class
CompletionRequirement

Responsibilities:

Defines a specific condition that needs to be met for completion
Stores how many credits are required
Indicates whether the requirement is mandatory or not
Supplies this requirement info to the completion check

Collaborators:

Programme
CompletionCheck

Card 7:CompletionLetter

Class
CompletionLetter

Responsibilities:

Stores the letter number once issued
Records when the letter was issued
Records how long the letter stays valid
Holds a verification code for the letter

Collaborators:

LetterRequest
LetterTemplate
VerificationCode
