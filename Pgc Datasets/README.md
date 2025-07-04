# Pgc Datasets

This folder contains the output datasets generated by the spatial assignment pipeline documented in `Function_Admin_GridCell.Rmd`. The process matches grid cells to administrative units (admin0, admin1, admin2) using spatial intersection and a bottom-up plurality rule. It also saves overlap diagnostics. The dataset that contains flags of unmatched grid cells and administrative units (orphans) is available upon request.

All datasets have been saved on .gpkg format (with geometry columns converted to WKT for compatibility).

## Saved Outputs

### Final Assignments

-   `valid_grid_admin_assignments.gpkg`\
    Grid cells assigned to the largest-overlapping valid administrative unit, using a hierarchical fallback (Admin2 → Admin1 → Admin0). Only valid admin units (those larger than the area of all grid cells they intersect with) were used.

-   `all_grid_admin_assignments.gpkg`\
    Grid cells assigned using all admin units, including both valid and non-valid units (smaller than the area of any grid cell they intersect with). Ensures full coverage by allowing matches to any overlapping unit.

### Grid–Admin Intersections

-   `grid_admin_all_levels_intersections.gpkg`\
    Long-format table showing all grid cell and admin unit intersections across levels (Admin0–2). Includes the area of overlap (in km²), the percent of grid cell area covered, and whether the admin unit is valid.

### Unassigned and Orphan Units

-   `no_parent_gid.gpkg`\
    Grid cells that could not be assigned to any administrative unit after the full bottom-up procedure. These are typically located in water bodies.

-   `orphans_admins.gpkg`\
    Administrative units that were too small to validly claim any grid cell. This includes Admin0, Admin1, and Admin2 units excluded from the assignment process.

## Reproducibility

These files were generated by the procedures implemented in `Function_Admin_GridCell.Rmd`, which: 1. Loads and filters raw spatial data. 2. Applies a plurality-based bottom-up matching algorithm. 3. Identifies unmatched grid cells and administrative units. 4. Saves matched results and diagnostics in GeoPackage format.
