#######################################################################
# Very simple script for assigning reviewers to conference abstracts. #
# Modify as needed.                                                   #
#                                                                     #
# Joshua McNeill - joshua dot mcneill at uga dot edu                  #
#######################################################################

# List reviewers and abstracts needed to review
reviewers <- c("Josh", "Rachel", "Amelia", "Keiko", "Kora", "Jean", "Katy", "Julia", "Tom", "Angela", "Trevor", "Timo")
abstracts_per_reviewer <- 3
reviewers_abstracts <- rep(reviewers, abstracts_per_reviewer)
abstracts <- seq(34)

# Generate reviewers equivalent to total abstracts
samp_reviewers <- function(reviewers, abstracts) {
  sample(reviewers, length(abstracts), replace = FALSE)
}

# Assign reviewers
assignments <- data.frame(
  abstract = abstracts,
  reviewer1 = samp_reviewers(reviewers_abstracts, abstracts),
  reviewer2 = samp_reviewers(reviewers_abstracts, abstracts),
  reviewer3 = samp_reviewers(reviewers_abstracts, abstracts)
)

# Make sure no one got the shaft
for (reviewer in reviewers) {
  count <- length(grep(reviewer, as.matrix(assignments)))
  print(paste(reviewer, "assigned to review", count, "abstracts"))
}

# Save reviewer assignments to csv
write.csv(assignments, file = "assignments.csv")
