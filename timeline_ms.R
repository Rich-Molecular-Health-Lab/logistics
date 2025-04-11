timeline_ms <- list(
  semester_1 = list(
    coursework = list(
      BIOL8150  = list("PROFESSIONAL DEVELOP BIOLOGY"             , 2),
      BIOL8896  = list("GENES, BRAIN, AND BEHAVIOR"               , 3),
      BMI8300   = list("PUBLIC HEALTH GENOMICS"                   , 3),
      BMKI9000  = list("GRANT WRITING FOR THE BIOMEDICAL SCIENCES", 3)
      ),
    thesis = list(
      "Settle on topic.",
      "Submit GRACA Proposal."
      )
    ),
  semester_2 = list(
    coursework = list(
      BIOL8250  = list("STATISTICS & DSGN FOR BIO RSCH", 4),
      BIOL8250  = list("ADVANCED READINGS IN BIOLOGY"  , 3)
    ),
    thesis = list(
      "Organize thesis committee.",
      "Secure IACUC, IBC, and AZA Permits.",
      "Begin sample collection/analysis."
    )
  ),
  semester_3 = list(
    coursework = list(
      BIOL8250 = list("ADVANCED READINGS IN BIOLOGY"  , 3),
      BIOL8020 = list("INDEPENDENT RESEARCH - BIOLOGY", 3)
    ),
    thesis = list(
      "Submit and defend thesis proposal.",
      "Finish all sample collection and lab analysis.",
      "Begin finalizing results for manuscript."
    )
  ),
    semester_4 = list(
      coursework = list(
        BIOL8010 = list("SEMINAR IN BIOLOGY", 1),
        BIOL8990 = list("THESIS"            , 6)
        ),
      thesis = list(
        "Finish all data analysis and writing.",
        "Present at at least one conference.",
        "Present department seminar.",
        "Submit and defend thesis.",
        "Submit manuscript for publication"
        )
      )
  )

electives <- list(
  cross_listed <- list(
    BMI8100   = list("INTRO TO BIOMED INFORMATICS", 3, "Fall"),
    CSCI8656  = list("INTRO TO CLOUD COMPUTING (Online)", 3, c("Fall", "Spring")),
    BIOL8866  = list("COMPARATIVE GENOMICS" , 3, "Spring"),
    BMI8896   = list("COMP GENETIC SEQUENCE ANALYSIS", 3, "Spring"),
    CSCI8325  = list("DATA STRUCTURES", 3, "Spring"),
    NEUR8166  = list("NEUROPHARMACOLOGY", 3, "Spring"),
    NEUR8336  = list("SOCIAL NEUROSCIENCE", 3, "Spring"),
    NEUR8486  = list("NEUROIMMUNOLOGY", 3, "Spring")
  ),
  unmc <- list(
    BMI825   = list("INTRODUCTION TO R PROGRAMMING FOR BIOMEDICINE", 3),
    EPI812   = list("CHRONIC DISEASE EPIDEMIOLOGY", 3),
    EPI820   = list("EPIDEMIOLOGY IN PUBLIC HEALTH", 3),
    EPI910   = list("RESEARCH GRANT PROPOSAL DEVELOPMENT", 3),
    EPI941   = list("EPIDEMIOLOGIC METHODS IN APPLIED CLINICAL GENETICS", 3)

  )
)
