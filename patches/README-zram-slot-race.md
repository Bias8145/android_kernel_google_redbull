# ZRAM slot-write race fix candidate

This patch is intentionally staged separately from `Test` until the exact 4.19 `zram_drv.c` hunk is validated against the Redbull tree.

Decision: YES — apply the upstream-compatible ZRAM slot-write race/resource-leak fix after source-level hunk validation.

Do not change compressor, swappiness, or ZRAM sizing as part of this fix.
