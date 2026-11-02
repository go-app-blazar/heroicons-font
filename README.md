# heroicons-font
A tool to create a web font for heroicons as well as a place to store that font.

This is intended to be used go `go-app-blazar`, so the fonts are bundled in a Go `embed.FS`, and constants are generated for each of the CSS classes.

# Updating Heroicons
Update `config.sh` and then run:

```
make clean all
```

Commit the changes and push.
