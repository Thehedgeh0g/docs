<?php
declare(strict_types=1);

namespace App\Editor\App;

class EditorService
{
    public function getFileData(string $path): string
    {
        return file_get_contents( __DIR__ . '/../../../../content/en' . $path . '.md');
    }

    public function saveNewFileData(string $path, string $content, string $originalPath = null): void
    {
        if ($originalPath !== $path)
        {
            unlink(__DIR__ . '/../../../../content/en' . $originalPath . '.md');
        }
        file_put_contents(__DIR__ . '/../../../../content/en' . $path . '.md', $content);
    }

    public function deleteFile(string $path): void
    {
        unlink(__DIR__ . '/../../../../content/en' . $path . '.md');
    }
}