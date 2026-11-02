package heroicons

import (
	"embed"
	"io/fs"
)

//go:embed embedded/*.*
var embeddedFS embed.FS

// FS is the embedded filesystem that contains the fonts at the root level.
var FS, _ = fs.Sub(embeddedFS, "embedded")
