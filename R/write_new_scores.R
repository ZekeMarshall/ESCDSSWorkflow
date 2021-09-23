at <- tar_read("wide_scores_at")
md <- tar_read("wide_scores_md")
ct <- tar_read("wide_scores_ct")
dams <- tar_read("wide_scores_dams")
snr <- tar_read("wide_scores_snr")
smr <- tar_read("wide_scores_smr")

write.csv(x = at, 
          file = file.path(x = new_scores, file = "new_scores_at.csv"),
          row.names = FALSE)

write.csv(x = md, 
          file = file.path(x = new_scores, file = "new_scores_md.csv"),
          row.names = FALSE)

write.csv(x = ct, 
          file = file.path(x = new_scores, file = "new_scores_ct.csv"),
          row.names = FALSE)

write.csv(x = dams, 
          file = file.path(x = new_scores, file = "new_scores_dams.csv"),
          row.names = FALSE)

write.csv(x = snr, 
          file = file.path(x = new_scores, file = "new_scores_snr.csv"),
          row.names = FALSE)

write.csv(x = smr, 
          file = file.path(x = new_scores, file = "new_scores_smr.csv"),
          row.names = FALSE)

