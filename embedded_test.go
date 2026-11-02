package heroicons_test

import (
	"io/fs"
	"testing"

	"github.com/go-app-blazar/heroicons-font"
	"github.com/stretchr/testify/assert"
	"github.com/stretchr/testify/require"
)

func TestEmbedded(t *testing.T) {
	files, err := fs.Glob(heroicons.FS, "*.*")
	require.NoError(t, err)
	assert.NotEmpty(t, files)
	assert.Contains(t, files, "hi-outline.css")
	assert.Contains(t, files, "hi-outline.woff2")
	assert.Contains(t, files, "hi-solid.css")
	assert.Contains(t, files, "hi-solid.woff2")
}
