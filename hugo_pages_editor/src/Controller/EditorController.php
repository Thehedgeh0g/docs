<?php
declare(strict_types=1);

namespace App\Controller;

use App\Editor\App\EditorService;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;

class EditorController extends AbstractController
{

    public function __construct(
        private EditorService $editorService,
    )
    {
    }

    public function edit(Request $request): Response
    {
        $data = $request->query->get('path', '');
        if (empty($data))
        {
            $fileData = '';
        }
        else
        {
            try
            {
                $fileData = $this->editorService->getFileData($data);
            }
            catch (\Throwable)
            {
                return new JsonResponse(['message' => 'not found'], Response::HTTP_NOT_FOUND);
            }
        }

        return $this->render('editor-page/editor-page.twig', [
            'path' => $data ?? '',
            'data' => $fileData,
        ]);
    }

    public function save(Request $request): Response
    {
        $data = json_decode($request->getContent(), true);
        if (!isset($data['content'], $data['path'], $data['originalPath']))
        {
            return new JsonResponse(['message' => 'not found'], Response::HTTP_BAD_REQUEST);
        }

        $this->editorService->saveNewFileData($data['path'], $data['content'], $data['originalPath']);
        return new JsonResponse(['message' => 'saved'], Response::HTTP_OK);
    }
}